module SByC
  module Matching
    class MatchData
      
      # Source AstNode of the matching
      attr_reader :source
      
      # Matched node
      attr_reader :matched_node
      
      # Captured variables
      attr_reader :captures
      
      # Creates a MatchData instance
      def initialize(source, matched_node, captures)
        @source, @matched_node, @captures = source, matched_node, captures
      end
      
      # Returns node matched under a given variable name
      def [](varname)
        captures[varname]
      end
      
      # Inspects this MatchData
      def inspect
        "MatchData#{captures.inspect}"
      end
      
    end # class MatchData
  end # module Matching
end # module SByC