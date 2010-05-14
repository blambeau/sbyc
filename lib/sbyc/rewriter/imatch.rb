module SByC
  class Rewriter
    class IMatch
      
      # Match Abstract Syntax Tree
      attr_reader :match_ast
      
      # Creates an IMatch instance
      def initialize(match_ast)
        @match_ast = match_ast
      end
      
      # Looks for a match against some ast node
      def =~(ast_node)
        match_data = {}
        return nil unless function_match(match_ast, ast_node, match_data)
        match_data
      end
      
      #
      # Applies function name matching. Cases that may arise:
      #   (match (_ :fname), ...)
      #   (match (? (_ :x)), ...)
      #
      def function_match(match_ast, ast_node, match_data = {})
        case fname = match_ast[0].function
          when :'_'
            return (match_ast[0].literal == ast_node.function ? true : false)
          when :'?'
            match_data[match_ast[0].literal] = ast_node.function
            return true
          else
            false
        end
      end
      
    end # class IMatch
  end # class Rewriter
end # module SByC