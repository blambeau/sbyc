module TypeSystem
  #
  # Defines the abstract contract that a TypeSystem should implement.
  #
  module Contract
    
    #
    # Returns the type of a value
    #
    def type_of(value)
    end
    
    #
    # Parse _str_ value literal and returns real value.
    #
    # @raise InvalidValueLiteralError if str does not look like a valid 
    #        value literal
    #
    def parse_literal(str)
    end
    
  end # module Contract
end # module TypeSystem