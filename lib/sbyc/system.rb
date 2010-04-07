module SByC
  module System
    
    ###########################################################################
    ### Class methods
    ###########################################################################
    class << self
      
      # Returns defined types
      def defined_types
        @defined_types ||= []
      end
      
      # Let the system know that a type has been added
      def add_type(type)
        defined_types << type
        type
      end
      
      # Installs the shortcuts
      def install_shortcuts
        defined_types.each do |type|
          next if type.name.nil? or type.name.empty?
          if type.respond_to?(:superclass) and (type.superclass == ::SByC::ScalarType)
            if type.__main_representation.name == :Main
              ::SByC::System.send(:define_method, type.name) {|*args|
                type.__main_representation.send(:[], *args)
              }
            end
          else
            ::SByC::System.send(:define_method, type.name) {|*args|
              type.send(:[], *args)
            }
          end
        end
      end
      
      # Make some type definitions
      def typedef
        yield
        install_shortcuts
      end
    
    end # class << self
    
    # Creates a builtin type instance
    def ScalarType(heading = nil, &block)
      if heading.nil? and block
        type = ::SByC::ScalarType::DSL::execute(&block)
      elsif heading and block.nil?
        type = ::SByC::ScalarType::DSL::execute{
          representation :Main, heading
        }
      end
      ::SByC::System::add_type(type)
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