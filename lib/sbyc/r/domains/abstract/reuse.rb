module SByC
  module R
    module AbstractDomain
      module Reuse

        # Reuse's class methods
        module ClassMethods
          
          # Ruby reused class
          attr_accessor :reused_class
          
          # Returns exemplars
          def exemplars
            []
          end
          
          # Checks if a value belongs to this domain
          def is_value?(value)
            value.class == self
          end
          
          # Raises a TypeError
          def parse_literal(str)
            if reused_class.respond_to?(:parse)
              begin
                return self.new(reused_class.parse(str))
              rescue => ex
                __not_a_literal__!(self, str)
              end
            end
            __not_a_literal__!(self, str)
          end
          alias :str_coerce :parse_literal
          
          # Returns a literal
          def to_literal(value)
            __not_a_valid_value__!(self, value)
          end
          
          # Coerces a ruby value
          def ruby_coerce(value)
            if value.class == reused_class
              self.new(value)
            else
              __not_a_valid_value__!(self, value)
            end
          end
          
        end # module ClassMethods

        # Reuse's instance methods
        module InstanceMethods
          
          # Reused value
          attr_reader :reused
          
          # Creates a value, reusing some ruby other value
          def initialize(reused)
            @reused = reused
          end
          
          # Returns domain 
          def domain
            self.class
          end
          
          # Returns an hashcode
          def hashcode
            @reused.hashcode
          end
          
          # Equality (ruby) operator
          def ==(other)
            other.kind_of?(self.class) && (@reused == other.reused)
          end
          
          protected :reused
        end # module InstanceMethods

      end # module Reuse
    end # module AbstractDomain
  end # module R
end # module SByC
