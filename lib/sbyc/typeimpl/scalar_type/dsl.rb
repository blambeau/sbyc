module SByC
  class ScalarType
    class DSL
      
      # Class under construction
      attr_reader :clazz
      
      # Creates a scalar type by execution of the block
      def self.execute(&block)
        DSL.new(&block).clazz
      end
      
      # Creates a DSL instance to populate a scalar type
      def initialize(&block)
        @clazz = Class.new(::SByC::ScalarType)
        instance_eval(&block)
      end
      
      # Adds a type representation  
      def representation(name, heading)
        @clazz.__add_possible_representation(name, ::SByC::Heading[heading])
      end
      
      # Adds a converter from two representations
      def converter(hash, &block)
        raise ArgumentError, "Hash of size 1 expected, #{hash.inspect} received" unless Hash===hash and hash.size==1
        @clazz.__add_conversion(hash.keys[0], hash.values[0], &block)
      end
      
    end # class DSL
  end # module ScalarType
end # module SByC