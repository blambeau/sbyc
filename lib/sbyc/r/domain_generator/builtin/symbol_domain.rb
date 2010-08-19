class SByC::R::DomainGenerator::Builtin
  module SymbolDomain
    
    def exemplars
      [ :var, :something_with_underscores, :'s#', :hello, :"s-b-y-c", :"12" ]
    end

    def is_value?(value)
      value.kind_of?(::Symbol)
    end

    def parse_literal(str)
      str = str.to_s.strip
      if str =~ /^:[^\s]+$/
        begin
          Kernel.eval(str)
        rescue Exception => ex
          __not_a_literal__!(self, str)
        end
      else
        __not_a_literal__!(self, str)
      end
    end

    def to_literal(value)
      value.inspect
    end
    
    def call_signature
      @call_signature ||= [ [::Symbol, ::String] ]
    end
    
    def coerce(runner, args, binding)
      case f = args.first
        when ::Symbol
          f
        when ::String
          unless f.strip.empty?
            f.strip.to_sym
          else
            call_error(runner, args, binding)
          end
        else
          call_error(runner, args, binding)
      end
    end
    
  end # module SymbolDomain
end # class SByC::R::DomainGenerator::Builtin