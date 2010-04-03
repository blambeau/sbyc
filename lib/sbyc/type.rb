module SByC
  module Type
      
    # Define a new sub type by constraint
    def such_that(&constraint)
      ::SByC::System::ConstraintType(self, constraint)
    end

  end # module Type
end # module SByC