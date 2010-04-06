module SByC
  module Value
    
    # Checks if this value belongs to a specific type
    def belongs_to?(type)
      raise ArgumentError, "::SByC::Type expected, #{type} received" unless type.respond_to?(:include_value?)
      type.include_value?(self)
    end
    
  end # module Value
end # module SByC