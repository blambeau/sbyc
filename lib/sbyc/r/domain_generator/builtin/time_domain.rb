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
    
    def call_signature
      @call_signature ||= [ [ ::Date, ::String ] ]
    end
    
    def coerce(runner, args, binding)
      case f = args.first
        when ::Time
          f
        when ::String
          begin 
            ::Time::parse(f)
          rescue => ex 
            call_error(runner, args, binding)
          end
        else
          call_error(runner, args, binding)
      end
    end
    
  end # module TimeDomain
end # class SByC::R::DomainGenerator::Builtin