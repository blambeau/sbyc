module SByC
  module CodeTree
    class ImperativeParser
      class Expr < ::SByC::CodeTree::BasicObject
        
        # Creates an expression instance
        def initialize(name = nil, children = nil)
          @name, @children = name, children
        end
        
        # Returns the associated functional code
        def __to_functional_code
          children = @children.collect{|c|
            c.kind_of?(Expr) ? c.__to_functional_code : AstNode.coerce(c)
          }
          ::SByC::CodeTree::AstNode.coerce([@name, children])
        end
        alias :inspect :__to_functional_code
        
        def method_missing(name, *args)
          res = if @name || args.length > 0
            args.unshift(self) if @name
            Expr.new(name, args)
          else
            method_missing(:__scope_get__, name)
          end
          res
        end
        
        def to_s(*args, &block) method_missing(:to_s, *args, &block) end
        def inspect(*args, &block) method_missing(:inspect, *args, &block) end
        def puts(*args, &block) method_missing(:puts, *args, &block) end
        def [](*args, &block)  
          if @name.nil?
            method_missing(:__scope_get__,  *args, &block);  
          else            
            method_missing(:[],  *args, &block);  
          end
        end
        def []=(*args, &block) method_missing(:[]=, *args, &block);  end
        def **(*args, &block)  method_missing(:**,  *args, &block);  end
        def ~(*args, &block)   method_missing(:~,   *args, &block);  end
        def ==(*args, &block)  method_missing(:==,  *args, &block);  end
        #def !=(*args, &block)  method_missing(:!=,  *args, &block);  end
        def -@(*args, &block)  method_missing(:-@,  *args, &block);  end
        def +@(*args, &block)  method_missing(:+@,  *args, &block);  end
        def -(*args, &block)   method_missing(:-,   *args, &block);  end
        def +(*args, &block)   method_missing(:+,   *args, &block);  end
        def *(*args, &block)   method_missing(:*,   *args, &block);  end
        def /(*args, &block)   method_missing(:/,   *args, &block);  end
        def %(*args, &block)   method_missing(:%,   *args, &block);  end
        def =~(*args, &block)  method_missing(:=~,  *args, &block);  end
        def ===(*args, &block) method_missing(:===, *args, &block);  end
        def &(*args, &block)   method_missing(:&,   *args, &block);  end
        def |(*args, &block)   method_missing(:|,   *args, &block);  end
        def >(*args, &block)   method_missing(:>,   *args, &block);  end
        def >=(*args, &block)  method_missing(:>=,  *args, &block);  end
        def <=(*args, &block)  method_missing(:<=,  *args, &block);  end
        def <(*args, &block)   method_missing(:<,   *args, &block);  end
        def >>(*args, &block)  method_missing(:>>,  *args, &block);  end
        def <<(*args, &block)  method_missing(:<<,  *args, &block);  end
        def ^(*args, &block)   method_missing(:'^', *args, &block);  end
        def <=>(*args, &block) method_missing(:<=>, *args, &block);  end

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
            ::SByC::CodeTree::LeafNode.new(e)
        end
      end
      
      # Parses a block
      def self.parse(code = nil, &block)
        block = code || block
        case block
          when Proc
            parse_proc(block)
          when String
            parse(Kernel.eval("proc{ #{block} }"))
          else
            raise ArgumentError, "Unable to parse #{block}"
        end
      end
      
    end # class ImperativeParser
  end # module CodeTree
end # module SByC