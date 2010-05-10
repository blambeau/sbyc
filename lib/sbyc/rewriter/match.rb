module SByC
  class Rewriter
    class Match
      
      # Creates a match instance
      def initialize(method_name, block)
        @method_name, @block = method_name, block
      end
      
      # Does this match 
      def ===(ast_node)
        @method_name == ast_node.name
      end
      
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