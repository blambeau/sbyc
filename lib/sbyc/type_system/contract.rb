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
    # Converts _value_ to a literal and returns it.
    #
    # This method should always be such that:
    #   v == parse_literal(to_literal(v))
    #
    # @raise NoSuchLiteralError if value cannot be expressed as a literal
    #
    def to_literal(value)
    end
    
    #
    # Parse _str_ value literal and returns real value.
    #
    # @raise InvalidValueLiteralError if str does not look like a valid 
    #        value literal
    #
    def parse_literal(str)
    end
    
    #
    # Coerces a string to a given class.
    #
    # @raise CoercionError if something goes wrong
    #
    def coerce(str, clazz)
    end
    
  end # module Contract
end # module TypeSystem