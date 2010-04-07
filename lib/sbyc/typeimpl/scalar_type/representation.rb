module SByC
  class ScalarType
    class Representation
      
      # Underlying type
      attr_reader :type
      
      # Representation's name
      attr_reader :name
      
      # Representation's heading
      attr_reader :heading
      
      # Creates a representation instance
      def initialize(type, name, heading)
        @type, @name, @heading = type, name, heading
        @converters = {}
        @struct = Struct.new(*heading.attribute_names(true))
      end
      
      # Creates a value
      def [](pairs)
        return pairs if pairs.is_a?(type)
        physrep = @heading.selector_helper(pairs)
        physrep = heading.attribute_names(true).collect{|k| physrep[k]}
        physrep = build_physrep(physrep)
        type.new(self, physrep)
      end
      
      # Builds a physical representation
      def build_physrep(args)
        @struct.new(*args)
      end
      
      # Returns true if a converter is known
      def has_converter?(to)
        @converters.has_key?(to)
      end
      
      # Adds a converter to another representation
      def add_converter(to, converter)
        @converters[to] = converter
      end
      
      # Converts this representation to another one
      def convert(my_physrep, to)
        to_physrep = to.build_physrep(Array.new(to.heading.degree, nil))
        @converters[to].call(my_physrep, to_physrep)
        to_physrep
      end
      
      # Returns a string representation
      def to_s
        "#{type}::#{name}"
      end
      
    end # class Representation
  end # class ScalarType
end # module SByC 