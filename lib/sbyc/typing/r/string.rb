module SByC
  module Typing
    module R
      class String < Typing::Domain
        class << self
          # Returns true if a given value belongs to this domain,
          # false otherwise
          def is_value?(value)
            value.kind_of?(::String)
          end
      
          # Parses a literal from the domain and returns
          # a value
          def parse_literal(str)
            str = str.to_s.strip
            if str =~ /^['](.*)[']$|^["](.*)["]$/
              begin
                Kernel.eval(str)
              rescue Exception => ex
                __not_a_literal__!(self, str)
              end
            else
              __not_a_literal__!(self, str)
            end
          end
      
          # Converts a value to a literal
          def to_literal(value)
            value.inspect
          end
      
          # Coerces a string to a value of the domain 
          def str_coerce(str)
            str
          end
        end # class << self
      end # class Boolean
    end # module R
  end # module Typing
end # module SByC