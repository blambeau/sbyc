require 'date'
require 'time'
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
       String,
       Symbol,
       Class, 
       Module,
       Regexp].each{|c| SAFE_LITERAL_CLASSES[c] = true}
    
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
        elsif value == (1.0/0)
          return '(1.0/0)'
        elsif value == -(1.0/0)
          return '(-1.0/0)'
        elsif SAFE_LITERAL_CLASSES.key?(type_of(value))
          value.inspect
        elsif value.kind_of?(Array)
          "[" + value.collect{|v| to_literal(v, optimistic)}.join(', ') + "]"
        elsif value.kind_of?(Hash)
          "{" + value.collect{|pair| "#{to_literal(pair[0], optimistic)} => #{to_literal(pair[1], optimistic)}"}.join(', ') + "}"
        elsif value.kind_of?(Date)
          "Date::parse(#{value.inspect})"
        elsif value.kind_of?(Time)
          "Time::parse(#{value.inspect})"
        elsif optimistic
          value.inspect
        else
          raise NoSuchLiteralError, "Unable to convert #{value.inspect} to a ruby literal"
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