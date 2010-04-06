module SByC
  module System
    
    ###########################################################################
    ### Class methods
    ###########################################################################
    class << self
      
      # Let the system know that a type has been added
      def add_type(type)
        ::SByC::System.send(:define_method, type.name) {|*args|
          type.send(:[], *args)
        } 
      end
    
    end # class << self
    
    # Creates a builtin type instance
    def ScalarType(heading)
      raise ArgumentError, "Hash or Heading expected, #{heading.class} received" unless Hash===heading or ::SByC::Heading===heading
      heading = ::SByC::Heading.new(heading) if Hash===heading
      clazz = Class.new(SByC::ScalarType)
      clazz.extend(SByC::ScalarType::ClassMethods)
      clazz.set_heading(heading)
      clazz
    end
    
    # # Wraps a ruby operator
    # def wrap_ruby_operator(name, signature, returned_type)
    #   method = signature[0].get_ruby_type.instance_method(name)
    #   signature[0].send(:define_method, name) {|*args|
    #     signature[1..-1].each_with_index do |s, i|
    #       raise ::SByC::TypeError, "Invalid operand #{args[i-1]}", caller unless s === args[i-1]
    #     end
    #     args = args.collect{|a| a.ruby_value}
    #     returned_type[method.bind(self.ruby_value).call(*args)]
    #   }
    # end
    
    extend(System)
  end # module System
end # module SByC