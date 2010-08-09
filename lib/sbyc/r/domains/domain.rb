module SByC
  module R
    module DomainDomain
      
      RUBY_TO_R = {
        'Fixnum'     => :Integer,
        'Bignum'     => :Integer,
        'FalseClass' => :Boolean,
        'TrueClass'  => :Boolean
      }
      
      # Returns the domain of this domain
      def domain
        ::Class
      end
      alias :sbyc_domain :domain

      # Returns true if a given value belongs to this domain,
      # false otherwise
      def is_value?(value)
        R::__all_domains__.include?(value)
      end
      
      # Returns all domains
      def values
        R::__all_domains__
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
        if name =~ /^SByC::R::(.*)$/
          $1
        else
          name
        end
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
    Domain = R::WrapRubyDomain(::Class, DomainDomain)
  end # module R
end # module SByC