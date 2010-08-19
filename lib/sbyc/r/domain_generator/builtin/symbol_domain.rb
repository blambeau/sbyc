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
    
    def coerce(x)
      if is_value?(x)
        x
      elsif x.kind_of?(::String)
        if x[0, 1] == ':'
          parse_literal(x)
        else
          x.to_sym
        end
      else
        super
      end
    end
    
    def sbyc_call(runner, args, binding)
      args = runner.ensure_args(args, [ [::Symbol, ::String] ], binding){
        runner.__selector_invocation_error__!(self, args)
      }
      case f = args.first
        when ::Symbol
          f
        when ::String
          unless f.strip.empty?
            f.strip.to_sym
          else
            runner.__selector_invocation_error__!(self, args)
          end
        else
          runner.__selector_invocation_error__!(self, args)
      end
    end
    
  end # module SymbolDomain
end # class SByC::R::DomainGenerator::Builtin