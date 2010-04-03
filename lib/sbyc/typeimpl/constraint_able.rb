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
      check = c.call(value)
      check = check.ruby_value if ::SByC::Boolean == check.class
      raise ::SByC::TypeImplementationError, "Constraint should return a Boolean"\
        unless true == check or false == check
      raise ::SByC::TypeError if (raise_on_error and not(check))
      check
    end
    
    # Checks type constraints, raising a TypeError if some fails
    def check_type_constraints(value)
      superclass.check_type_constraints(value) if superclass.respond_to?(:check_type_constraints)
      type_constraints.all?{|c| check_type_constraint(c, value, true)}
    end
      
  end # module SByC
end # module SByC