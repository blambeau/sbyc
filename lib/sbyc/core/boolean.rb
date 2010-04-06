module Boolean

  module ClassMethods
    include ::SByC::BuiltinType
    
    # Checks if this type includes a value
    def __basically_include_value?(value)
      (true == value) || (false == value)
    end
    
  end
  extend(ClassMethods)
  
  # True value
  TRUE  = true
  
  # False value
  FALSE = false
  
end # class Boolean
[TrueClass, FalseClass].each{|t| t.instance_eval{ include(::SByC::Value) }}
::SByC::System.add_type(::Boolean)