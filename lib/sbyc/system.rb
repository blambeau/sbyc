module SByC
  module System
    
    # Creates a variable with a given type and initial value
    def variable(type, initial_value) 
      Variable.new(type, type[initial_value])
    end
    
    # Creates a builtin type instance
    def BuiltinType(ruby_type)
      clazz = Class.new(SByC::Builtin::BuiltinType)
      clazz.extend(SByC::Builtin::BuiltinType::ClassMethods)
      clazz.set_ruby_type(ruby_type)
      clazz
    end
    
    # Asserts something is true
    def assert(something, msg = "Assertion failed: expected false to be true")
      raise ::SByC::AssertionError, msg, caller unless something
    end
    
    extend(System)
  end # module System
end # module SByC