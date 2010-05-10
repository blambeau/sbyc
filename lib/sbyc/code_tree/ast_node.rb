module SByC
  module CodeTree
    class AstNode
      include Enumerable
      
      # Name of the method call
      attr_reader :name
  
      # Children nodes
      attr_reader :children
  
      # Lambda function, if any
      attr_reader :lambda
  
      # Operator found by type checking
      attr_reader :operator
      
      # Creates an ASTNode instance
      def initialize(name, children, lambda)
        @name, @children, @lambda = name, children, lambda
      end
    
      # Returns false
      def leaf?
        false
      end
    
      # Negation of leaf?
      def branch?
        not(leaf?)
      end
    
      # Yields block with each child in turn  
      def each(&block)
        children.each(&block)
      end
      
      # Inspection
      def inspect
        "(#{name} #{children.collect{|c| c.inspect}.join(', ')})"
      end
      
      # Returns a short string representation
      def to_s
        "(#{name} ...)"
      end
      
      # Returns an array version of this ast
      def to_a
        lambda ? [name, children.collect{|c| c.to_a}, lambda] : [name, children.collect{|c| c.to_a}]
      end
      
      # Applies type checking
      def type_check(system)
        arg_types = children.collect{|c| c.type_check(system).return_type}
        unless @operator = system.find_operator(name, arg_types)
          raise ::SByC::TypeCheckingError, "Unable to find operator (#{name} #{arg_types.join(', ')})"
        end
        @operator
      end
      
      # Converts to ruby code
      def to_ruby_code(system)
        operator.to_ruby_code(system, children.collect{|c| c.to_ruby_code(system)})
      end
      
      # Coercion
      def self.coerce(arg)
        case arg
          when AstNode
            arg
          when Array
            name, children, lambda = arg
            AstNode.new(name, children.collect{|c| AstNode.coerce(c)}, lambda)
          else
            LeafNode.new(arg)
        end
      end
      
    end # module AstNode
  end # module CodeTree
end # module SByC 