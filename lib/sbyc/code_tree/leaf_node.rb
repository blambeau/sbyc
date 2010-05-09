module SByC
  module CodeTree
    class LeafNode < AstNode
      
      # Literal attached to this node
      attr_reader :literal
      
      # Creates a leaf node instance
      def initialize(literal)
        @literal = literal
      end
      
      # Returns "literal"
      def name
        :literal
      end
      
      # Returns an empty array
      def children
        []
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
      
      # Applies type checking
      def type_check(system)
        signature = ::SByC::System::Signature.coerce([[], literal.class])
        @operator = ::SByC::System::Operator.new(:__literal__, signature, literal.inspect)
      end
      
      # Converts to ruby code
      def to_ruby_code(system)
        literal.inspect
      end
      
    end # class LeafNode
  end # module CodeTree
end # module SByC