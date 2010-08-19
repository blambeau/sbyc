class SByC::R::DomainGenerator::Builtin
  module IntegerDomain
    
    # Returns exemplars
    def exemplars
      [ -(2**(0.size * 8 - 2)), -1, 0, 1, 10, (2**(0.size * 8 - 2) - 1)] +
      [ -(2**(0.size * 8 - 2)) - 1, (2**(0.size * 8 - 2)) ]
    end
    
    # Returns true if a given value belongs to this domain,
    # false otherwise
    def is_value?(value)
      value.kind_of?(::Integer)
    end

    # Parses a literal from the domain and returns
    # a value
    def parse_literal(str)
      str = str.to_s.strip
      if str =~ /^[-+]?[0-9]+$/
        str.to_i
      else
        __not_a_literal__!(self, str)
      end
    end

    # Converts a value to a literal
    def to_literal(value)
      value.inspect
    end
  
    def call_signature(runner, args, binding)
      @call_signature ||= [ [::Fixnum, ::Bignum, ::String] ]
    end
      
    def coerce(runner, args, binding)
      case f = args.first
        when ::Integer
          f
        when /^[-+]?[0-9]+$/
          f.to_s.to_i
        else
          call_error(runner, args, binding)
      end
    end
    
  end # module IntegerDomain
end # class SByC::R::DomainGenerator::Builtin