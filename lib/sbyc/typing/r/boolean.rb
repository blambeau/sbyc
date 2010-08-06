module SByC
  module Typing
    module R
      class Boolean < Typing::Domain
        class << self
          # Returns true if a given value belongs to this domain,
          # false otherwise
          def is_value?(value)
            value == true || value == false
          end
      
          # Parses a literal from the domain and returns
          # a value
          def parse_literal(str)
            str = str.strip
            if str == 'true'
              return true
            elsif str == 'false'
              return false
            else
              __not_a_literal__!(self, str)
            end
          end
      
          # Converts a value to a literal
          def to_literal(value)
            value == true ? "true" : "false"
          end
      
          # Coerces a string to a value of the domain 
          def str_coerce(str)
            raise NotImplementedError
          end
        end # class << self
      end # class Boolean
    end # module R
  end # module Typing
end # module SByC