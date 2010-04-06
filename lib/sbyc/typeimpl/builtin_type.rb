module SByC
  # 
  # This module is included by Ruby classes that are used as builtin 
  # types.
  #
  module BuiltinType
    include ::SByC::Type
    
    # Type selector.
    def [](value)
      raise selector_invocation_error(self, value) unless include_value?(value)
      value
    end
    
    # Implements ::SByC::Type::sbyc
    def sbyc(&constraint)
      if self.is_a?(Class)
        clazz = Class.new(self)
      else
        clazz = Class.new
        clazz.extend(self.const_get('ClassMethods')) if self.const_defined?('ClassMethods')
        clazz.instance_eval{ include(::SByC::Value) }
      end
      me = self
      clazz.instance_eval{ @supertype = me }
      clazz.extend(::SByC::ConstraintAble)
      clazz.add_type_constraint(constraint)
      clazz
    end
    
  end # module BuiltinType
end # module SByC
