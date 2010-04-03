module SByC
  module System
    
    # Creates a builtin type instance
    def BuiltinType(ruby_type)
      clazz = Class.new(SByC::Builtin::BuiltinType)
      clazz.extend(SByC::Builtin::BuiltinType::ClassMethods)
      clazz.set_ruby_type(ruby_type)
      clazz
    end
    
    # Wraps a ruby operator
    def wrap_ruby_operator(name, signature, returned_type)
      method = signature[0].get_ruby_type.instance_method(name)
      signature[0].send(:define_method, name) {|*args|
        args = args.collect{|a| a.ruby_value}
        returned_type[method.bind(self.ruby_value).call(*args)]
      }
    end
    
    extend(System)
  end # module System
end # module SByC