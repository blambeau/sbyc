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
      
      # Evaluates this AST with an object style.
      def object_eval(scope = nil) 
        cs = children.collect{|c| c.object_eval(scope)}
        res = case name
          when :__scope_get__
            scope[*cs]
          else
            cs[0].send(name, *cs[1..-1])
        end
        res
      end
      
      # Evaluates this AST with an object style.
      def functional_eval(master_object, scope = nil) 
        cs = children.collect{|c| c.functional_eval(master_object, scope)}
        res = case name
          when :__scope_get__
            scope[*cs]
          else
            master_object.send(name, *cs)
        end
        res
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