module SByC
  module Type
      
    def sbyc(&constraint)
      raise ::SByC::TypeSystemError, "#{self} should impement sbyc"
    end

  end # module Type
end # module SByC