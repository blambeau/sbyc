module SByC
  module ConstraintAble
      
    # Returns type constraints
    def type_constraints
      @type_constraints ||= []
    end
    
    # Adds a type constraint
    def add_type_constraint(constraint)
      type_constraints << constraint
    end
    
    # Checks a type constraint and always return a ruby base boolean.
    # Raises a TypeError if the constraint is violated and raise_on_error
    # is true
    def check_type_constraint(c, value, raise_on_error = false)
      unless c.call(value)
        raise ::SByC::TypeError if raise_on_error
        false
      else
        true
      end
    end
    
    # Checks type constraints, raising a TypeError if some fails
    def check_type_constraints(value, raise_on_error = false)
      type_constraints.all?{|c| check_type_constraint(c, value, raise_on_error)}
    end
      
  end # module SByC
end # module SByC