module SByC
  module R
    module DomainImpl
      module CommonMethods
        
        # Returns the domain of this domain
        def domain
          R::Domain
        end
        alias :sbyc_domain :domain
    
        # Coerces from a ruby value
        def ruby_coerce(value)
          return value if is_value?(value)
          __not_a_valid_value__!(self, value)
        end
        
        # Coerces a value
        def coerce(value)
          if is_value?(value)
            return value
          elsif value.kind_of?(String) 
            str_coerce(value) 
          else
            ruby_coerce(value)
          end
        end
        
        # Returns short name
        def short_name
          if name =~ /::([^:]+)$/
            $1
          else
            name
          end
        end
    
      end # module CommonMethods
    end # class DomainImpl
  end # module R
end # module SByC

