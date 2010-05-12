module SByC
  module CodeTree
    class AstNode
      include Enumerable
      
      # Name of the method call
      attr_reader :name
      alias :function :name
  
      # Children nodes
      attr_reader :children
      alias :arg :children
  
      # Operator found by type checking
      attr_reader :operator
      
      # Creates an ASTNode instance
      def initialize(name, children)
        @name, @children = name, children
      end
      
      # Returns first children.
      def literal
        children.first
      end
    
      # Returns false
      def leaf?
        (name == :_)
      end
    
      # Negation of leaf?
      def branch?
        not(leaf?)
      end
    
      # Yields block with each child in turn  
      def each(&block)
        children.each(&block)
      end
      
      # Makes a depth-first-search visit of the AST
      def visit(&block)
        yield(self, leaf? ? children : children.collect{|c| c.visit(&block)})
      end
      
      # Inspection
      def inspect
        "(#{name} #{children.collect{|c| c.inspect}.join(', ')})"
      end
      
      # Returns a short string representation
      def to_s
        leaf? ? literal.inspect : "(#{name} #{children.collect{|c| c.to_s}.join(', ')})"
      end
      
      # Returns an array version of this ast
      def to_a
        visit{|node, collected| [node.name, collected]}
      end
      
      # Coercion
      def self.coerce(arg)
        case arg
          when AstNode
            arg
          when Array
            name, children = arg
            AstNode.new(name, children.collect{|c| AstNode.coerce(c)})
          else
            AstNode.new(:_, [ arg ])
        end
      end
      
    end # module AstNode
  end # module CodeTree
end # module SByC 