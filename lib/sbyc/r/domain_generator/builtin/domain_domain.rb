class SByC::R::DomainGenerator::Builtin
  module DomainDomain
    
    def exemplars
      [ system::Alpha, system::Domain, system::Boolean ]
    end
    
    def is_value?(value)
      value.respond_to?(:sbyc_domain) and value.sbyc_domain == self
    end
    
    def values
      system::domains
    end

    def decode_domain_generation(str)
      R::parse(str, :parse_method => :parse_domain_generation_literal).visit{|node, collected|
        case f = node.function
          when :'_'
            node.literal
          when :'generate-domain'
            generator = collected.shift
            generator.domain_generator.generate(str, *collected)
          else
            __not_a_literal__!(self, str)
        end
      }
    rescue
      __not_a_literal__!(self, str)
    end

    def parse_literal(str)
      if str.to_s[-1, 1] == ">"
        decode_domain_generation(str)
      else
        found = __find_ruby_module__(str, SByC::R)
        found = __find_ruby_module__(str) unless found
        if found and is_value?(found) 
          found
        else
          __not_a_literal__!(self, str)
        end
      end
    end

    def to_literal(value)
      name = value.domain_name.to_s
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