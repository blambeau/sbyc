module SByC
  # A heading as a collection of (attribute => type) pairs.
  class Heading
    
    # Creates a heading instance
    def initialize(pairs)
      raise ArgumentError, "Invalid heading pairs #{pairs.inspect}" unless Hash===pairs
      raise ArgumentError, "Invalid heading pairs #{pairs.inspect}" unless pairs.keys.all?{|s| Symbol === s}
      raise ArgumentError, "Invalid heading pairs #{pairs.inspect}" unless pairs.values.all?{|s| ::SByC::Type === s}
      @pairs = pairs
    end
    
    # Checks if an attribute exists
    def has_attribute?(attribute_name)
      @pairs.has_key?(attribute_name)
    end
    
    # Returns the type of an attribute
    def type_of(attribute_name)
      @pairs[attribute_name]
    end
    
    # Checks if a given tuple looks valid for this heading
    def is_valid_tuple?(tuple = {})
      (tuple.size == @pairs.size) and \
      @pairs.keys.all?{|k| type_of(k) === tuple[k]}
    end
    
  end # class Heading
end # module SByC