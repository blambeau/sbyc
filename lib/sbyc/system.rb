module SByC
  module System
    
    # Creates a builtin type instance
    def ScalarType(ruby_type)
      clazz = Class.new(SByC::ScalarType)
      clazz.extend(SByC::ScalarType::ClassMethods)
      clazz.set_ruby_type(ruby_type)
      clazz.add_type_constraint(Kernel.lambda{|value| 
        value.respond_to?(:ruby_value) and (ruby_type === value.ruby_value)
      })
      clazz
    end
    
    # Creates a constrained type
    def ConstraintType(base, constraint)
      clazz = Class.new(base)
      clazz.set_ruby_type(base.get_ruby_type)
      clazz.add_type_constraint(constraint)
      clazz
    end
    
    # Wraps a ruby operator
    def wrap_ruby_operator(name, signature, returned_type)
      method = signature[0].get_ruby_type.instance_method(name)
      signature[0].send(:define_method, name) {|*args|
        signature[1..-1].each_with_index do |s, i|
          raise ::SByC::TypeError, "Invalid operand #{args[i-1]}", caller unless s === args[i-1]
        end
        args = args.collect{|a| a.ruby_value}
        returned_type[method.bind(self.ruby_value).call(*args)]
      }
    end
    
    extend(System)
  end # module System
end # module SByC