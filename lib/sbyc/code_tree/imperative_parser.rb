module SByC
  module CodeTree
    class ImperativeParser < BasicParser
      class Expr < BasicParser
        
        # Creates an expression instance
        def initialize(str = nil)
          @str = str
        end
        
        # Returns the associated functional code
        def __to_functional_code
          @str
        end
        alias :inspect :__to_functional_code
        
        def method_missing(name, *args)
          if @str || args.length > 0
            args.unshift(self) if @str
            Expr.new("(#{name} #{args.collect{|a| a.inspect}.join(', ')})")
          else
            method_missing(OPERATOR_NAMES[:[]], name)
          end
        end
        
        def [](*args, &block)  method_missing(OPERATOR_NAMES[:[]],  *args, &block);  end
        def []=(*args, &block) method_missing(OPERATOR_NAMES[:[]=], *args, &block);  end
        def **(*args, &block)  method_missing(OPERATOR_NAMES[:**],  *args, &block);  end
        def ~(*args, &block)   method_missing(OPERATOR_NAMES[:~],   *args, &block);  end
        def ==(*args, &block)  method_missing(OPERATOR_NAMES[:==],  *args, &block);  end
        #def !=(*args, &block)  method_missing(OPERATOR_NAMES[:!=],  *args, &block);  end
        def -@(*args, &block)  method_missing(OPERATOR_NAMES[:-@],  *args, &block);  end
        def +@(*args, &block)  method_missing(OPERATOR_NAMES[:+@],  *args, &block);  end
        def -(*args, &block)   method_missing(OPERATOR_NAMES[:-],   *args, &block);  end
        def +(*args, &block)   method_missing(OPERATOR_NAMES[:+],   *args, &block);  end
        def *(*args, &block)   method_missing(OPERATOR_NAMES[:*],   *args, &block);  end
        def /(*args, &block)   method_missing(OPERATOR_NAMES[:/],   *args, &block);  end
        def %(*args, &block)   method_missing(OPERATOR_NAMES[:%],   *args, &block);  end
        def =~(*args, &block)  method_missing(OPERATOR_NAMES[:=~],  *args, &block);  end
        def ===(*args, &block) method_missing(OPERATOR_NAMES[:===], *args, &block);  end
        def &(*args, &block)   method_missing(OPERATOR_NAMES[:&],   *args, &block);  end
        def |(*args, &block)   method_missing(OPERATOR_NAMES[:|],   *args, &block);  end
        def >(*args, &block)   method_missing(OPERATOR_NAMES[:>],   *args, &block);  end
        def >=(*args, &block)  method_missing(OPERATOR_NAMES[:>=],  *args, &block);  end
        def <=(*args, &block)  method_missing(OPERATOR_NAMES[:<=],  *args, &block);  end
        def <(*args, &block)   method_missing(OPERATOR_NAMES[:<],   *args, &block);  end
        def >>(*args, &block)  method_missing(OPERATOR_NAMES[:>>],  *args, &block);  end
        def <<(*args, &block)  method_missing(OPERATOR_NAMES[:<<],  *args, &block);  end
        def ^(*args, &block)   method_missing(OPERATOR_NAMES[:'^'], *args, &block);  end
        def <=>(*args, &block) method_missing(OPERATOR_NAMES[:<=>], *args, &block);  end

        def coerce(other)
          [self, other]
        end

      end # class Expr
      
      # Parses a Proc object
      def self.parse_proc(block)
        e = case block.arity
          when -1
            Expr.new.instance_eval(&block)
          when 1
            block.call(Expr.new)
          else
            raise ArgumentError, "Unexpected block arity #{block.arity}"
        end
        case e
          when Expr
            ::SByC::CodeTree::FunctionalParser::parse(e.__to_functional_code)
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