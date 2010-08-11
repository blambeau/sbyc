module SByC
  module CodeTree
    class AstNode
      
      # Source interval for this ast node
      attr_accessor :source_interval
      def source; source_interval.source; end
      def start_index; source_interval.start_index end
      def stop_index; source_interval.stop_index end
      
      # Name of the method call
      attr_accessor :name
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
        yield(self, leaf? ? children : children.collect{|c| c.respond_to?(:visit) ? c.visit(&block) : c})
      end
    
      # Renames some nodes, given a name2name map.
      def rename!(map = nil, &block)
        map = CodeTree::Name2X::Delegate.coerce(map || block)
        visit{|node, collected|
          newname = map.name2name(node.name)
          node.send(:name=, newname) if newname
          nil
        }
        self
      end
    
      # Inject code through module mapped to function names
      def code_inject!(map = nil, &block)
        map = CodeTree::Name2X::Delegate.coerce(map || block)
        visit{|node, collected| 
          ext = map.name2module(node.function)
          node.extend(ext) if ext
          nil
        }
        self
      end
    
      # Create class instances
      def digest(map = nil, &block)
        map = CodeTree::Name2X::Delegate.coerce(map || block)
        visit{|node, collected| 
          if node.leaf?
            node.literal
          else
            ext = map.name2class(node.function)
            raise "Unexpected node function: #{node.function}" unless ext
            ext.new(*collected)
          end
        }
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
            if name.kind_of?(Symbol) and children.kind_of?(Array)
              if name == :_ and children.size == 1
                AstNode.new(:_, children)
              else
                AstNode.new(name, children.collect{|c| AstNode.coerce(c)})
              end
            else
              AstNode.new(:_, [ arg ])
            end
          else
            AstNode.new(:_, [ arg ])
        end
      end
    
      private :name=
    end # module AstNode
  end # module CodeTree
end # module SByC