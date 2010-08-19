module SByC
  module R 
    module Robustness
  
      # Raised when a type error occurs
      class ::SByC::TypeError < ::SByC::Error; end
  
      # Raised when a nil value occurs
      class ::SByC::NilError < ::SByC::Error; end
  
      # Raised when a type checking error occurs
      class ::SByC::TypeCheckError < ::SByC::Error; end
      
      # Raised when an error occurs inside a selector
      class ::SByC::SelectorInvocationError < ::SByC::Error; end
      
      # Raised when an invalid domain generation occurs
      class ::SByC::InvalidDomainGenerationError < ::SByC::Error; end
      
      # Raised when someone does not look a callable
      class ::SByC::NotACallableError < ::SByC::Error; end
      
      # Raised when a signature mistmatch occurs
      class ::SByC::SignatureError < ::SByC::Error; end
      
      # Raised when an operator cannot be found
      class ::SByC::UndefinedOperatorError < ::SByC::Error; end
  
      # Raised when an assertion fails
      class ::SByC::AssertionError < ::SByC::Error; end
  
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
  
      # Raises a NilError with a given message
      def __nil_error__(msg, cal = caller)
        raise ::SByC::NilError, msg, cal
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
  
      # Rauses a TypeCheckError with a specific message
      def __selector_invocation_error__!(domain, args, cal = caller)
        raise ::SByC::SelectorInvocationError, \
          "Invalid selector invocation (#{domain.domain_name} #{args.join(' ')})", cal
      end
      
      # Raises an InvalidDomainGenerationError
      def __domain_generation_error__!(generator, args, cal = caller)
        raise ::SByC::InvalidDomainGenerationError, "Invalid domain generation (#{generator} #{args.join(' ')})", cal
      end
      
      def __not_a_callable_error__!(who, cal = caller)
        raise ::SByC::NotACallableError, "#{who} does not look a callable", cal
      end
      
      def __undefined_operator__!(operator, args, cal = caller)
        raise ::SByC::UndefinedOperatorError, "Undefined operator (#{operator} #{args.join(', ')})", cal
      end
      
      def __signature_mistmatch__!(function, args, cal = caller)
        raise ::SByC::SignatureError, "Signature mistmatch for (#{function} #{args.join(' ')})", cal
      end
      
      def __args_have_arity__!(function, args, arity, cal = caller)
        raise ::SByC::SignatureError, "Signature mistmatch for (#{function} #{args.join(' ')})", cal\
          unless args.size == arity
      end
      
      def __equal__!(arg1, arg2, cal = caller)
        raise ::SByC::AssertionError, "Expected #{arg1.inspect}, got #{arg2.inspect}", cal\
          unless arg1 == arg2
        true
      end
  
      def __not_equal__!(arg1, arg2, cal = caller)
        raise ::SByC::AssertionError, "Expected #{arg1.inspect}, got #{arg2.inspect}", cal\
          if arg1 == arg2
        true
      end
      
      def __assert_callable__!(who, cal = caller)
        __not_a_callable_error__!(who, cal) unless who.respond_to?(:sbyc_call)
        who
      end
  
      extend(Robustness)
    end # module Robustness
  end # module R
end # module SByC