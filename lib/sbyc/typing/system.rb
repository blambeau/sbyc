module SByC
  module Typing
    module System
      
      # Returns the domain of a value
      def domain_of(value)
        if value.respond_to?(:sbyc_domain)
          return value.sbyc_domain
        else
          ruby_coerce(value)[1]
        end
      end
      alias :type_of :domain_of
      
      # Converts a value to a literal
      def to_literal(value)
        domain_of(value).to_literal(value)
      end
      
      # Parses a literal
      def parse_literal(literal)
        domains.each{|d| 
          begin
            return d.parse_literal(literal)
          rescue SByC::TypeError
          end
        }
        __not_a_literal__!(self, literal)
      end
      
      # Coerces a value from ruby itself
      def ruby_coerce(value)
        if value.respond_to?(:sbyc_domain)
          return [value, value.sbyc_domain] 
        else
          found = domains.find{|d| d.is_value?(value)}
          if found
            [value, found]
          else
            raise SByC::TypeError, "Unable to coerce #{value.inspect} to #{self} type system"
          end
        end
      end
      
    end # module System
  end # module Typing
end # module SByC