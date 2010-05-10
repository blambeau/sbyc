module SByC
  class Rewriter
    class Match
      
      # Creates a match instance
      def initialize(predicate, block)
        @predicate, @block = predicate, block
      end
      
      # Does this match 
      def matches?(ast_node)
        case @predicate
          when Symbol
            ast_node.name == @predicate
          when Proc
            @predicate.call(ast_node)
          else
            raise "Unexpected predicate #{@predicate}"
        end
      end
      alias :=== :matches?
      
      # Applies this match
      def apply(rewriter, ast_node)
        case ast_node
          when ::SByC::CodeTree::LeafNode
            @block.call(rewriter, ast_node)
          when ::SByC::CodeTree::AstNode
            @block.call(rewriter, *ast_node.children)
          else
            ast_node
        end
      end
      
    end # class Match
  end # class Rewriter
end # module SByC