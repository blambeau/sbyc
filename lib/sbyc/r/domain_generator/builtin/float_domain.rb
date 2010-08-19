class SByC::R::DomainGenerator::Builtin
  module FloatDomain

    # Returns exemplars
    def exemplars
      [ -1.0, 0.0, 1.0 ]
    end
    
    # Returns true if a given value belongs to this domain,
    # false otherwise
    def is_value?(value)
      value.kind_of?(::Float)
    end

    # Parses a literal from the domain and returns
    # a value
    def parse_literal(str)
      str = str.to_s.strip
      if str =~ /^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$/
        return str.to_f
      else
        __not_a_literal__!(self, str)
      end
    end

    # Converts a value to a literal
    def to_literal(value)
      value.inspect
    end
    
    def call_signature(runner)
      @call_signature ||= [ [::Float, ::Fixnum, ::Bignum, ::String] ]
    end
    
    def coerce(runner, args, binding)
      case f = args.first
        when ::Float
          f
        when ::Fixnum, ::Bignum
          f.to_f
        when /^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$/
          f.to_s.to_f
        else
          call_error(runner, args, binding)
      end
    end
    
  end # module FloatDomain
end # class SByC::R::DomainGenerator::Builtin