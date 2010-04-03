module SByC
  module Type
    module ClassMethods
      
      # Returns type constraints
      def type_constraints
        @type_constraints ||= []
      end
      
      # Adds a type constraint
      def add_type_constraint(constraint)
        type_constraints << constraint
      end
      
      # Checks type constraints, raising a TypeError if some fails
      def check_type_constraints(value)
        superclass.check_type_constraints(value) if superclass.respond_to?(:check_type_constraints)
        type_constraints.each do |c|
          check = c.call(value)
          raise ::SByC::TypeImplementationError, "Constraint should return a Boolean"\
            unless ::SByC::Builtin::Boolean === check
          raise ::SByC::TypeError, "Constraint #{c} failed" unless check.ruby_value
        end
      end

      # Define a new sub type by constraint
      def such_that(&constraint)
        ::SByC::System::ConstraintType(self, constraint)
      end

    end # module ClassMethods
  end # module Type
end # module SByC