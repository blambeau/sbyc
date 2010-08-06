module SByC
  module Typing
    module R
      class Integer < R::Domain
        
        class << self
          
          # Returns true if a given value belongs to this domain,
          # false otherwise
          def is_value?(value)
            value.kind_of?(::Integer)
          end
      
          # Parses a literal from the domain and returns
          # a value
          def parse_literal(str)
            str = str.to_s.strip
            if str =~ /^[-+]?[0-9]+$/
              str.to_i
            else
              __not_a_literal__!(self, str)
            end
          end
          alias :str_coerce :parse_literal
      
          # Converts a value to a literal
          def to_literal(value)
            value.inspect
          end
      
        end # class << self
        
      end # class Integer
    end # module R
  end # module Typing
end # module SByC