class SByC::R::DomainGenerator::Builtin
  module TimeDomain
    
    def exemplars
      [ ::Time.at(0), ::Time.utc(2010, 8, 5, 12, 15, 00) ]
    end

    def is_value?(value)
      value.kind_of?(::Time)
    end

    def parse_literal(str)
      str = str.to_s.strip
      if str =~ /^\(Time (.*)\)$/
        ::Time::parse($1)
      else
        __not_a_literal__!(self, str)
      end
    end

    def to_literal(value)
      "(Time #{value.inspect.inspect})"
    end
    
    def coerce(x)
      if is_value?(x)
        x
      elsif x.kind_of?(::String)
        begin
          ::Time::parse(x)
        rescue 
          parse_literal(x)
        end
      else
        super
      end
    end
    
    def sbyc_call(runner, args, binding)
      args = runner.ensure_args(args, [ [ ::Date, ::String ] ], binding){
        runner.__selector_invocation_error__!(self, args)
      }
      case f = args.first
        when ::Time
          f
        when ::String
          begin 
            ::Time::parse(f)
          rescue => ex 
            runner.__selector_invocation_error__!(self, args)
          end
      end
    end
    
  end # module TimeDomain
end # class SByC::R::DomainGenerator::Builtin