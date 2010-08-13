class SByC::R::DomainGenerator::Builtin
  module DomainDomain
    
    def exemplars
      [ R::Alpha, R::Domain, R::Boolean ]
    end
    
    def is_value?(value)
      R::domains.include?(value)
    end
    
    def values
      R::domains
    end

    def parse_literal(str)
      found = __find_ruby_module__(str, SByC::R)
      found = __find_ruby_module__(str) unless found
      if found and is_value?(found) 
        found
      else
        __not_a_literal__!(self, str)
      end
    end

    def to_literal(value)
      name = value.name.to_s
      (name =~ /^SByC::R::(.*)$/) ? $1 : name
    end

    RUBY_TO_R = {
      'Fixnum'     => :Integer,
      'Bignum'     => :Integer,
      'FalseClass' => :Boolean,
      'TrueClass'  => :Boolean,
      'Array'      => :Array
    }
    def coerce(x)
      if is_value?(x)
        return x 
      elsif x.kind_of?(::Class)
        parse_literal(RUBY_TO_R[x.name.to_s] || x.name)
      elsif x.kind_of?(::String)
        parse_literal(RUBY_TO_R[x] || x)
      else 
        super
      end
    end
      
  end # module DomainDomain
end # class SByC::R::DomainGenerator::Builtin