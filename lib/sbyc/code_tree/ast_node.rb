module SByC
  module CodeTree
    class AstNode
      include Enumerable
      
      # Name of the method call
      attr_reader :name
      alias :function :name
  
      # Children nodes
      attr_reader :children
      alias :args :children
  
      # Operator found by type checking
      attr_reader :operator
      
      # Creates an ASTNode instance
      def initialize(name, children)
        @name, @children = name, children
      end
      
      # Delegated to the children array
      def [](*args, &block)
        children.[](*args, &block)
      end
      
      # Recursively finds the first literal.
      def literal
        leaf? ? children[0] : children[0].literal
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
        case function
          when :'_'
            literal.inspect
          when :'?'
            literal.to_s
          else
            "(#{name} #{children.collect{|c| c.to_s}.join(', ')})"
        end
      end
      
      # Returns an array version of this ast
      def to_a
        visit{|node, collected| [node.name, collected]}
      end
      
      # Checks tree equality with another node 
      def ==(other)
        return false unless other.kind_of?(AstNode)
        return false unless (function == other.function)
        return false unless args.size == other.args.size
        return false unless args.zip(other.args).all?{|v1, v2| v1 == v2}
        true
      end
      
      # Coercion
      def self.coerce(arg)
        case arg
          when AstNode
            arg
          when Array
            name, children = arg
            if name == :_ and children.size == 1
              AstNode.new(:_, children)
            else
              AstNode.new(name, children.collect{|c| AstNode.coerce(c)})
            end
          else
            AstNode.new(:_, [ arg ])
        end
      end
      
    end # module AstNode
  end # module CodeTree
end # module SByC 