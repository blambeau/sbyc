module Boolean
  include ::SByC::Type
  
  module ClassMethods
    
    # Type selector
    def [](ruby_value)
      case ruby_value
        when TrueClass
          TRUE
        when FalseClass
          FALSE
        else 
          raise ::SByC::TypeError, "Invalid selector invocation #{self}[#{ruby_value}]"
      end
    end
    
    # Checks if this type includes a value
    def include_value?(value)
      (true == value) || (false == value)
    end
    alias :=== :include_value?
    
  end
  extend(ClassMethods)
  
  # True value
  TRUE  = true
  
  # False value
  FALSE = false
  
end # class Boolean
[TrueClass, FalseClass].each{|t| t.instance_eval{ include(::SByC::Value) }}
::SByC::System.add_type(::Boolean)