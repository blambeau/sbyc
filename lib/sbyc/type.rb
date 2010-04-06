module SByC
  module Type

    # Raises a TypeError.
    def selector_invocation_error(clazz, value)
      raise TypeError, "Invalid selector invocation #{clazz}[#{value}]", caller
    end
      
    # Checks if a value belongs to this type, returning true or false, accordingly.
    def include_value?(value)
      return false if (superclass.respond_to?(:include_value?) and not(superclass.include_value?(value)))
      if self.respond_to?(:check_type_constraints)
        check_type_constraints(value, false)
      else 
        value.class == self
      end
    end
    alias :=== :include_value?
    
    # Creates a subtype of this type based on a constraint given by the block.
    def sbyc(&constraint)
      raise ::SByC::TypeSystemError, "#{self} should impement sbyc"
    end
    
    # Alias for sbyc
    def such_that(&constraint)
      sbyc(&constraint)
    end

  end # module Type
end # module SByC