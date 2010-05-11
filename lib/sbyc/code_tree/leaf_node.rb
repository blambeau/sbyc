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
        :literal
      end
      
      # Returns an empty array
      def children
        []
      end
      
      # Evaluates this AST inside a given scope and with an object style
      def object_eval(scope = nil)
        literal
      end
      # Evaluates this AST inside a given scope and with a functional style
      def functional_eval(master_object, scope = nil)
        literal
      end
      
      # Inspection
      def inspect
        "#{literal.inspect}"
      end
      
      # Returns a short string representation
      def to_s
        "#{literal.inspect}"
      end
      
      # Returns an array version of this ast
      def to_a
        literal
      end
      
    end # class LeafNode
  end # module CodeTree
end # module SByC