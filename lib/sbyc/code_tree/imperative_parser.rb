module SByC
  module CodeTree
    class ImperativeParser < BasicParser
      class Expr
        
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
          args.unshift(self) if @str
          Expr.new("(#{name} #{args.collect{|a| a.inspect}.join(', ')})")
        end
        
        def [](*args, &block)  method_missing(:ref, *args, &block);      end
        def ==(*args, &block)  method_missing(:eq, *args, &block);       end
        def -@(*args, &block)  method_missing(:minus, *args, &block);    end
        def +@(*args, &block)  method_missing(:plus, *args, &block);     end
        def -(*args, &block)   method_missing(:minus, *args, &block);    end
        def +(*args, &block)   method_missing(:plus, *args, &block);     end
        def =~(*args, &block)  method_missing(:match, *args, &block);    end
        def ===(*args, &block) method_missing(:matches?, *args, &block); end
        def &(*args, &block)   method_missing(:bool_and, *args, &block); end
        def |(*args, &block)   method_missing(:bool_or, *args, &block);  end
        def >(*args, &block)   method_missing(:gt, *args, &block);       end
        def >=(*args, &block)  method_missing(:gte, *args, &block);      end
        def <=(*args, &block)  method_missing(:lte, *args, &block);      end
        def <(*args, &block)   method_missing(:lt, *args, &block);       end

        def coerce(other)
          [self, other]
        end

      end # class Expr
      
      # Parses a block
      def self.parse(code = nil, &block)
        block = code || block
        case block
          when Proc
            e = block.call(Expr.new)
            return ::SByC::CodeTree::FunctionalParser::parse(e.__to_functional_code)
          when String
            parse(Kernel.eval("proc{ #{block} }"))
          else
            raise ArgumentError, "Unable to parse #{block}"
        end
      end
      
    end # class ImperativeParser
  end # module CodeTree
end # module SByC