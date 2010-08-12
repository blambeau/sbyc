module SByC
  module R
    module AbstractDomain
      module Domain
        
      
        #######################################################################
        ### About coercion
        #######################################################################
        
        # Coerces from a ruby value
        def ruby_coerce(value)
          return value if is_value?(value)
          __not_a_valid_value__!(self, value)
        end
        
        # Coerces a value
        def coerce(value)
          if is_value?(value)
            return value
          elsif value.kind_of?(::String) 
            str_coerce(value) 
          else
            ruby_coerce(value)
          end
        end
        
      end # module Domain
    end # module AbstractDomain
  end # module R
end # module SByC
