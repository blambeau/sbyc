module CodeTree
  module Name2X
    
    # Coerce something to a Name2X
    def self.coerce(arg)
      case arg
        when Hash
          arg
        when Module
          Name2Module.new(arg)
        else
          if arg.respond_to?(:[])
            arg
          else
            raise ArgumentError, "Unable to coerce #{arg} to a Name2X contract"
          end
      end
    end
    
    # Implements the Name2X contract to convert operator
    # names to a module sub module...
    class Name2Module
      
      # The super module used as naming reference
      attr_reader :super_module
      
      # Creates a converter instance
      def initialize(super_module)
        @super_module = super_module
      end
      
      # Upcase a given name
      def capitalize_name(name)
        name.to_s.capitalize
      end
      
      # Returns the module to use, or nil if not found
      def [](name)
        name = capitalize_name(name)
        super_module.const_defined?(name) ? super_module.const_get?(name) : nil
      end
      
    end # Name2Module
    
  end # module Name2X
end # module CodeTree