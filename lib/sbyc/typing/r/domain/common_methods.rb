module SByC
  module Typing
    module R
      class Domain
        module CommonMethods
          
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
      
        end # module CommonMethods
      end # class Domain
    end # module R
  end # module Typing
end # module SByC
