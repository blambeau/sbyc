module SByC::R::DomainGenerator::Tools
  module ReuseDomain
    
    attr_accessor :domain_name
    
    def exemplars
      []
    end
    
    def is_value?(value)
      value.class.ancestors.include?(self)
    end

    def parse_literal(str)
      str = str.to_s.strip
      if str =~ /^\(/
        system::evaluate({}, str)
      else
        __not_a_literal__!(self, str)
      end
    end

    def to_literal(value)
      value.to_s
    end
    
    def coerce(x)
      if is_value?(x)
        x
      elsif x.kind_of?(::String)
        parse_literal(x)
      else
        super
      end
    end
    
  end # module ReuseDomain
end # module SByC::R::DomainGenerator::Tools