module SByC
  class Variable
    
    # Definition type
    attr_reader :definition_type
    
    # Current value
    attr_reader :value
    
    # Creates a variable instance
    def initialize(definition_type, value)
      @definition_type, @value = definition_type, value
    end
    
    # Returns the variable type
    def type
      definition_type
    end
    
  end # class Variable
end # module SByC