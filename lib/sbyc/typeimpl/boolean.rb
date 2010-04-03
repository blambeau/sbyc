class SByC::Boolean
  
  # Type selector
  def self.[](ruby_value)
    case ruby_value
      when TrueClass
        TRUE
      when FalseClass
        FALSE
      else 
        raise ::SByC::TypeError, "Invalid selector invocation #{self}[#{ruby_value}]"
    end
  end
  
  # Undelying ruby value
  attr_reader :ruby_value
  
  # Creates a boolean instance
  def initialize(ruby_value)
    @ruby_value = ruby_value
  end
  
  # True value
  TRUE  = SByC::Boolean.new(true)
  
  # False value
  FALSE = SByC::Boolean.new(false)
  
end