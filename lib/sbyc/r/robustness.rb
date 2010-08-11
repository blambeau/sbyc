module SByC
  module R 
    module Robustness
  
      # Raised when a type error occurs
      class ::SByC::TypeError < ::SByC::Error; end
  
      # Raised when a type checking error occurs
      class ::SByC::TypeCheckError < ::SByC::Error; end
  
      # Finds a ruby module by name or returns nil
      def __find_ruby_module__(name, start = ::Kernel)
        name = name.to_s.strip
        if name.empty?
          nil
        else
          begin
            parts, current = name.split("::"), start
            parts.each{|part| current = current.const_get(part.to_sym)}
            current
          rescue Exception => ex
            nil
          end
        end
      end
  
      # Raises a TypeError with a message explaining that _str_
      # is not a literal for _domain_
      def __not_a_literal__!(domain, str, cal = caller)
        raise ::SByC::TypeError, "Invalid domain literal #{str.inspect} for #{domain.name}", cal
      end
    
      # Raises a TypeError with a message explaining that _value_
      # cannot be coerced to a given domain
      def __not_a_valid_value__!(domain, value, cal = caller)
        raise ::SByC::TypeError, "Unable to coerce #{value.inspect} (#{value.class}) to #{domain.name}", cal
      end
    
      # Rauses a TypeCheckError with a specific message
      def __type_check_error__!(msg, cal = caller)
        raise ::SByC::TypeCheckError, msg, cal
      end
  
      extend(Robustness)
    end # module Robustness
  end # module R
end # module SByC