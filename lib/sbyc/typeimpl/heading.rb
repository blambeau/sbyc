module SByC
  # A heading as a collection of (attribute => type) pairs.
  class Heading
    
    # Alias for Heading.new
    def self.[](pairs)
      Heading === pairs ? pairs : Heading.new(pairs)
    end
    
    # Creates a heading instance
    def initialize(pairs)
      raise ArgumentError, "Invalid heading pairs #{pairs.inspect}, not a hash #{pairs.class}" unless Hash===pairs
      raise ArgumentError, "Invalid heading pairs #{pairs.inspect}, bad attributes" unless pairs.keys.all?{|s| Symbol === s}
      raise ArgumentError, "Invalid heading pairs #{pairs.inspect}, bad types" unless pairs.values.all?{|s| ::SByC::Type === s}
      @pairs = pairs
    end
    
    # Returns heading degree (number of components)
    def degree
      @pairs.size
    end
    
    # Checks if an attribute exists
    def has_attribute?(attribute_name)
      @pairs.has_key?(attribute_name)
    end
    
    # Returns the type of an attribute
    def type_of(attribute_name)
      @pairs[attribute_name]
    end
    
    # Returns an array of attribute names
    def attribute_names(sorted = false)
      sorted ? @pairs.keys.sort{|a1, a2| a1.to_s <=> a2.to_s} : @pairs.keys
    end
    
    # Yields the block on each (attribute, type) pair
    def each_pair
      @pairs.each_pair{|a,t| yield(a,t)}
    end
    
    # Checks if a given tuple looks valid for this heading
    def is_valid_tuple?(tuple = {})
      (tuple.size == degree) and \
      @pairs.keys.all?{|k| type_of(k) === tuple[k]}
    end
    
    # Converts a hash by applying type selectors to its different elements
    def selector_helper(tuple = {})
      if Hash===tuple
        raise ::SByC::TypeError unless tuple.size == degree
        result = {}
        @pairs.keys.all?{|k| result[k] = type_of(k)[tuple[k]]}
        result
      elsif degree==1
        selector_helper(attribute_names[0] => tuple)
      else
        raise ::SByC::TypeError, "Invalid selector invocation #{self.inspect} with #{tuple.inspect}"
      end
    end
    
  end # class Heading
end # module SByC