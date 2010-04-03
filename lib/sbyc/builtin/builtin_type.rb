module SByC
  module Builtin
    class BuiltinType
      
      # Class methods
      module ClassMethods
        
        # Returns the underlying ruby type
        def get_ruby_type
          @ruby_type
        end
        
        # Sets the underlying ruby type
        def set_ruby_type(ruby_type)
          @ruby_type = ruby_type
        end
        
        # Selects a type instance 
        def [](literal)
          case literal 
            when get_ruby_type
              self.new(literal)
            when self
              self.new(literal.ruby_value)
            else 
              raise ::SByC::TypeError, "Invalid selector invocation #{self}[#{literal}]"
          end
        end
        
      end # module ClassMethods
      
      # Underlying ruby value
      attr_reader :ruby_value
      
      # Creates a builtin type instance
      def initialize(ruby_value)
        @ruby_value = ruby_value
      end
      
      # Checks equality with another value
      def ==(value)
        (value.class == self.class) and (@ruby_value == value.ruby_value)
      end
      
      # Returns a string representation
      def to_s
        @ruby_value.to_s
      end
      
      # Returns a SByC representation
      def inspect
        "#{self.class}[#{@ruby_value}]"
      end
      
    end # class BuiltinType
  end # module Builtin
end # module SByC