module SByC
  module R
    module DomainDomain
      
      RUBY_TO_R = {
        'Fixnum'     => :Integer,
        'Bignum'     => :Integer,
        'FalseClass' => :Boolean,
        'TrueClass'  => :Boolean
      }
            
      # Returns true if a given value belongs to this domain,
      # false otherwise
      def is_value?(value)
        R::domains.include?(value)
      end
      
      # Returns all domains
      def values
        R::domains
      end
  
      # Parses a literal from the domain and returns
      # a value
      def parse_literal(str)
        found = __find_ruby_module__(str, SByC::R)
        found = __find_ruby_module__(str) unless found
        if found and is_value?(found) 
          found
        else
          __not_a_literal__!(self, str)
        end
      end
      alias :str_coerce :parse_literal
  
      # Converts a value to a literal
      def to_literal(value)
        name = value.name.to_s
        (name =~ /^SByC::R::(.*)$/) ? $1 : name
      end

      # Coerces from a ruby value
      def ruby_coerce(value)
        if is_value?(value)
          return value 
        elsif value.kind_of?(::Class)
          parse_literal(RUBY_TO_R[value.name.to_s] || value.name)
        elsif value.kind_of?(::String)
          parse_literal(RUBY_TO_R[value] || value)
        else 
          super
        end
      end
        
    end # module DomainDomain
    Domain = R::RefineUnionDomain(:Domain, Alpha, DomainDomain)
  end # module R
end # module SByC