module SByC
  module Typing
    module R
      class Domain
        module RootMethods
          
          # Installs the prinstine methods when inherited
          def inherited(subclass)
            subclass.extend(R::Domain::PrinstineMethods)
            prinstine_domains << subclass
          end
          
          # Returns all values of this domain (that is, the prinstine 
          # domains)
          def prinstine_domains
            @prinstine_domains ||= []
          end
          alias :values :prinstine_domains
          
          # Returns the domain of this domain
          def domain
            ::Class
          end

          # Returns true if a given value belongs to this domain,
          # false otherwise
          def is_value?(value)
            value.kind_of?(::Class) and value.ancestors.include?(R::Domain)
          end
      
          # Parses a literal from the domain and returns
          # a value
          def parse_literal(str)
            found = __find_ruby_module__(str, SByC::Typing::R)
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
            if name =~ /^SByC::Typing::R::(.*)$/
              $1
            else
              name
            end
          end
          
        end # module RootMethods
      end # class Domain
    end # module R
  end # module Typing
end # module SByC