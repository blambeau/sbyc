module SByC
  module Matching
    class Matcher
      
      # Match Abstract Syntax Tree
      attr_reader :match_ast
      
      # Creates an IMatch instance
      def initialize(match_ast)
        @match_ast = match_ast
      end
      
      # Looks for a match against some ast node
      def =~(ast_node)
        if captures = do_match(match_ast, ast_node)
          ::SByC::Matching::MatchData.new(ast_node, ast_node, captures)
        else
          nil
        end
      end
      alias :match :=~
      alias :call :=~
      
      # Returns true if _ast_node_ is matched by this matcher,
      # false otherwise
      def ===(ast_node)
        not((self =~ ast_node).nil?)
      end
      
      # Lookups for a match between _matcher_ and _matched_.
      def do_match(matcher, matched, match_data = {})
        return nil unless matched.kind_of?(::SByC::CodeTree::AstNode)
        return nil unless function_match(matcher, matched, match_data)
        return nil unless args_match(matcher.args[1..-1], matched.args.dup, match_data)
        return match_data
      end
      
      #
      # Applies function name matching, returning true if _ast_node_'s function name
      # is matched by first argument of _match_ast_.
      #
      # Cases that may arise:
      #   (match (_ :fname), ...)   # true iif ast_node.function == fname
      #   (match (? (_ :x)), ...)   # true and match_data[x] = ast_node.function
      #   false otherwise
      #
      def function_match(match_ast, ast_node, match_data = {})
        case fname = match_ast[0].function
          when :'_'
            return (match_ast[0].literal == ast_node.function ? true : false)
          when :'?'
            match_data[match_ast[0].literal] = ast_node.function
            return true
        end
        false
      end
      
      # 
      # Applies arguments matching, return true if there is a match,
      # false otherwise.
      #
      def args_match(matchers, candidates, match_data = {})
        matchers.each do |m|
          case m.function
            when :'?'
              return false if candidates.empty?
              match_data[m.literal] = candidates.shift
            when :'_'
              return false if candidates.empty?
              return false unless candidates.shift.literal == m.literal
            when :'[]'
              return false if candidates.empty?
              match_data[m.literal] = candidates
              candidates = []
            else
              return false if candidates.empty?
              return false unless do_match(m, candidates.shift, match_data)
          end
        end
        candidates.empty?
      end

    end # class Matcher
  end # module Matching
end # module SByC