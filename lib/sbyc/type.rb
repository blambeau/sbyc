module SByC
  module Type

    # Returns the SByC super type, if any
    def supertype
      @supertype || nil
    end

    # Raises a TypeError.
    def selector_invocation_error(clazz, value)
      raise TypeError, "Invalid selector invocation #{clazz}[#{value}]", caller
    end
      
    # Checks if a value belongs to this type, returning true or false, accordingly.
    def include_value?(value)
      return false if (supertype and not(supertype.include_value?(value)))
      if self.respond_to?(:check_type_constraints)
        check_type_constraints(value, false)
      else 
        __basically_include_value?(value)
      end
    end
    
    # Checks if a value basically belongs to this type, bypassing constraints and other
    # stuff like that.
    def __basically_include_value?(value)
      value.class == self
    end
    
    # Alias for include_value?
    def ===(value)
      include_value?(value)
    end
    
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