module SByC
  # 
  # This module is included by Ruby classes that are used as builtin 
  # types.
  #
  module BuiltinType
    include ::SByC::Type
    
    # Type selector.
    def [](value)
      raise selector_invocation_error(self, value) unless belongs_to?(value)
      value
    end
    
    # Checks if a value belongs to this type
    def belongs_to?(value)
      self === value
    end
    
    # Implements ::SByC::Type::sbyc
    def sbyc(&constraint)
      clazz = Class.new(self)
      clazz.extend(::SByC::ConstraintAble)
      clazz.add_type_constraint(constraint)
      clazz
    end
    
  end # module BuiltinType
end # module SByC
[::String, ::Fixnum, ::Float, ::Time].each{|t| t.extend(SByC::BuiltinType)}