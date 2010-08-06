module SByC
  module Typing
    module R
      class Module < R::Domain
        
        class << self
          
          # Returns true if a given value belongs to this domain,
          # false otherwise
          def is_value?(value)
            value.kind_of?(::Module)
          end
      
          # Parses a literal from the domain and returns
          # a value
          def parse_literal(str)
            str = str.to_s.strip
            unless str.empty?
              begin
                parts, current = str.split("::"), Kernel
                parts.each{|part| current = current.const_get(part.to_sym)}
                if is_value?(current)
                  return current 
                else
                  __not_a_literal__!(self, str)
                end
              rescue Exception => ex
                __not_a_literal__!(self, str)
              end
            else
              __not_a_literal__!(self, str)
            end
          end
          alias :str_coerce :parse_literal
      
          # Converts a value to a literal
          def to_literal(value)
            value.name
          end
      
        end # class << self
        
      end # class Module
    end # module R
  end # module Typing
end # module SByC