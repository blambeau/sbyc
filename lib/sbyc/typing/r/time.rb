module SByC
  module Typing
    module R
      class Time < Typing::Domain
        class << self
          # Returns true if a given value belongs to this domain,
          # false otherwise
          def is_value?(value)
            value.kind_of?(::Time)
          end
      
          # Parses a literal from the domain and returns
          # a value
          def parse_literal(str)
            str = str.to_s.strip
            if str =~ /^Time\((.*)\)$/
              R::Time($1)
            else
              __not_a_literal__!(self, str)
            end
          end
      
          # Converts a value to a literal
          def to_literal(value)
            "Time(#{value.inspect.inspect})"
          end
          
          # Coerces a string to a time
          def str_coerce(str)
            R::Time(str)
          end
      
        end # class << self
      end # class Time
    end # module R
  end # module Typing
end # module SByC