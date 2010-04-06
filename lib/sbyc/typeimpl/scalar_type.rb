module SByC
  class ScalarType
    
    # Class methods
    module ClassMethods
      include ::SByC::Type
      include ::SByC::ConstraintAble
      
      # Returns the underlying heading
      def heading
        @heading
      end
      
      # Sets the underlying ruby type
      def set_heading(heading)
        @heading = heading
        heading.each_pair do |name, type|
          define_method(name) {
            self.physrep[name]
          }
        end
      end
      
      # Implements ::SByC::Type::sbyc
      def sbyc(&constraint)
        clazz = Class.new(self)
        clazz.set_heading(heading)
        clazz.add_type_constraint(constraint)
        clazz
      end
    
      # Selects a type instance 
      def [](literal)
        self.new(heading.selector_helper(literal))
      end
      
    end # module ClassMethods
    
    # Underlying ruby value
    attr_reader :physrep
    
    # Creates a builtin type instance
    def initialize(physrep)
      @physrep = physrep.freeze
      raise ::SByC::TypeError, "Selector invocation error #{self.class}[#{physrep.inspect}]" unless self.class.include_value?(self)
    end
    
    # Creates a new value by copy-and-modify 
    def update(updating)
      raise ArgumentError, "Hash expected" unless Hash===updating 
      self.class[physrep.dup.merge(updating)]
    end
    
    # Checks equality with another value
    def ==(value)
      @physrep == value.physrep
    end
    
    # Returns a string representation
    def to_s
      "#{self.class}[#{@physrep.inspect}]"
    end
    
    # Returns a SByC representation
    def inspect
      "#{self.class}[#{@physrep.inspect}]"
    end
    
  end # class ScalarType
end # module SByC