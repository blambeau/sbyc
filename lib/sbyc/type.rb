module SByC
  module Type

    # Raises a TypeError.
    def selector_invocation_error(clazz, value)
      raise TypeError, "Invalid selector invocation #{clazz}[#{value}]", caller
    end
      
    # Checks if a value belongs to this type, returning true or false, accordingly.
    def belongs_to?(value)
      return false if (superclass.respond_to?(:belongs_to?) and not(superclass.belongs_to?(value)))
      if self.respond_to?(:check_type_constraints)
        check_type_constraints(value, false)
      else 
        value.class == self
      end
    end
    alias :=== :belongs_to?
    
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