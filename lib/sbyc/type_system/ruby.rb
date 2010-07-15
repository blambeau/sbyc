module TypeSystem
  # 
  # Implements a basic TypeSystem that mimics Ruby's type system.
  #
  module Ruby
    
    # Methods
    module Methods
      
      # Ruby classes for which value.inspect will work for returning
      # a valid literal
      SAFE_LITERAL_CLASSES = {}
      [NilClass, TrueClass, FalseClass,
       Fixnum, Bignum,
       Float, 
       String].each{|c| SAFE_LITERAL_CLASSES[c] = true}
    
      #
      # Returns value.class
      #
      # @see TypeSystem::Contract#type_of
      #
      def type_of(value)
        value.class
      end
  
      #
      # Converts _value_ to a ruby literal and returns it.
      #
      # If _optimistic_ is set to true, implemented algorithm falls back to 
      # <code>value.inspect</code> if it does not recognize the value, i.e. 
      # hoping that the required contract invariant will be respected. 
      # It raises a NoSuchLiteralError otherwise 
      #
      # @see TypeSystem::Contract#to_literal(value)
      #
      def to_literal(value, optimistic = false)
        if value.respond_to?(:to_ruby_literal)
          value.to_ruby_literal
        elsif SAFE_LITERAL_CLASSES.key?(type_of(value))
          value.inspect
        elsif optimistic
          value.inspect
        else
          raise NoSuchLiteralError, "Unable to convert #{value} to a ruby literal"
        end
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