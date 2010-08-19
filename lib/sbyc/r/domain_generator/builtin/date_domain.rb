class SByC::R::DomainGenerator::Builtin
  module DateDomain
    
    # Returns exemplars
    def exemplars
      [ ::Date.today ]
    end
    
    # Returns true if a given value belongs to this domain,
    # false otherwise
    def is_value?(value)
      value.kind_of?(::Date)
    end

    # Parses a literal from the domain and returns
    # a value
    def parse_literal(str)
      str = str.to_s.strip
      if str =~ /^\(Date (.*)\)$/
        ::Date::parse($1)
      else
        __not_a_literal__!(self, str)
      end
    end

    # Converts a value to a literal
    def to_literal(value)
      "(Date #{value.to_s.inspect})"
    end
    
    def call_signature(runner, args, binding)
      @call_signature ||= [ [ ::Date, ::String ] ]
    end
    
    def coerce(runner, args, binding)
      case f = args.first
        when ::Date
          f
        when ::String
          begin 
            ::Date::parse(f)
          rescue => ex 
            call_error(runner, args, binding)
          end
        else
          call_error(runner, args, binding)
      end
    end
    
  end # module DateDomain
end # class SByC::R::DomainGenerator::Builtin