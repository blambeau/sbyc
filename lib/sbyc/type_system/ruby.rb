module TypeSystem
  # 
  # Implements a basic TypeSystem that mimics Ruby's type system.
  #
  module Ruby
    
    # Methods
    module Methods
    
      #
      # Returns value.class
      #
      # @see TypeSystem::Contract#type_of
      #
      def type_of(value)
        value.class
      end
  
      #
      # Returns result of Kernel.eval(str)
      #
      # @see TypeSystem::Contract#coerce(str)
      #
      def parse_literal(str)
        Kernel.eval(str)
      rescue Exception => ex
        raise TypeSystem::InvalidValueLiteralError, "Invalid ruby value literal #{str.inspect}", ex
      end

    end # module Methods
    extend(Methods)
    
  end # class Ruby
end # module TypeSystem