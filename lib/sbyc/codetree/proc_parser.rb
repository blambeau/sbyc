module CodeTree
  class ProcParser
    class Expr
      
      # Methods that we keep
      KEPT_METHODS = [ "__send__", "__id__", "instance_eval", "initialize", "object_id", 
                       "singleton_method_added", "singleton_method_undefined", "method_missing",
                       "__evaluate__", "coerce"]

      class << self
        def __clean_scope__
          # Removes all methods that are not needed to the class
          (instance_methods + private_instance_methods).each do |m|
            m_to_s = m.to_s
            undef_method(m_to_s.to_sym) unless ('__' == m_to_s[0..1]) or KEPT_METHODS.include?(m_to_s)
          end
        end
      end
    
      # Creates an expression instance
      def initialize(name = nil, children = nil)
        class << self; __clean_scope__; end
        @name, @children = name, children
      end
      
      # Returns the associated functional code
      def __to_functional_code
        children = @children.collect{|c|
          c.kind_of?(Expr) ? c.__to_functional_code : AstNode.coerce(c)
        }
        CodeTree::AstNode.coerce([@name, children])
      end
      alias :inspect :__to_functional_code
      
      # Called when a method is missing
      def method_missing(name, *args)
        if @name.nil?
          if name == :[]
            Expr.new(:'?', args)
          elsif args.empty?
            Expr.new(:'?', [name])
          else
            Expr.new(name, args)
          end
        else
          args.unshift(self)
          Expr.new(name, args)
        end
      end
      
      def coerce(other)
        [self, other]
      end

    end # class Expr
    
    # Parses a Proc object
    def self.parse_proc(block)
      e = case block.arity
        when -1, 0
          Expr.new.instance_eval(&block)
        when 1
          block.call(Expr.new)
        else
          raise ArgumentError, "Unexpected block arity #{block.arity}"
      end
      case e
        when Expr
          e.__to_functional_code
        else
          CodeTree::AstNode.coerce(e)
      end
    end
    
    # Parses a block
    def self.parse(code = nil, &block)
      block = code || block
      case block
        when Proc
          parse_proc(block)
        when AstNode
          block
        when String
          parse(Kernel.eval("proc{ #{block} }"))
        else
          raise ArgumentError, "Unable to parse #{block}"
      end
    end
    
  end # class ProcParser
end # module CodeTree