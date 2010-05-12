module SByC
  module CodeTree
    class LeafNode < AstNode
      
      # Literal attached to this node
      attr_reader :literal
      
      # Creates a leaf node instance
      def initialize(literal)
        @literal = literal
      end
      
      # Returns false
      def leaf?
        true
      end
    
      # Returns "literal"
      def name
        :__literal__
      end
      
      # Returns an empty array
      def children
        [ literal ]
      end
      
      # Makes a depth-first-search visit of the AST
      def visit(&block)
        yield self, [literal]
      end
      
      # Returns a string representation
      def to_s
        literal.inspect
      end
      
      # Evaluates this AST inside a given scope and with an object style
      def object_eval(scope = nil)
        literal
      end

      # Evaluates this AST inside a given scope and with a functional style
      def functional_eval(master_object, scope = nil)
        literal
      end
      
    end # class LeafNode
  end # module CodeTree
end # module SByC