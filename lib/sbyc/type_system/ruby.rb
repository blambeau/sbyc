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
      # Behavior of the algorithm when th value cannot be recognized depends
      # on the :fallback option:
      #   * when set to :fail, it raises a NoSuchLiteralError
      #   * when set to :inspect, it returns <code>value.inspect</code>
      #   * when set to :marshal it uses <code>Marshal::dump(value)</code>
      #   * when set to :json it uses <code>JSON::generate(value)</code>
      #
      # @see TypeSystem::Contract#to_literal(value)
      #
      def to_literal(value, options = {:fallback => :fail})
        if value.respond_to?(:to_ruby_literal)
          value.to_ruby_literal
        elsif value == (1.0/0)
          return '(1.0/0)'
        elsif value == -(1.0/0)
          return '(-1.0/0)'
        elsif SAFE_LITERAL_CLASSES.key?(type_of(value))
          value.inspect
        elsif value.kind_of?(Array)
          "[" + value.collect{|v| to_literal(v, options)}.join(', ') + "]"
        elsif value.kind_of?(Hash)
          "{" + value.collect{|pair| "#{to_literal(pair[0], options)} => #{to_literal(pair[1], options)}"}.join(', ') + "}"
        elsif value.kind_of?(Date)
          "Date::parse(#{value.to_s.inspect})"
        elsif value.kind_of?(Time)
          "Time::parse(#{value.inspect.inspect})"
        else
          case options[:fallback]
            when :inspect
              value.inspect
            when :marshal
              "Marshal::load(#{Marshal::dump(value).inspect})"
            when :json
              require 'json'
              JSON::generate(value)
            when :fail, nil
              raise NoSuchLiteralError, "Unable to convert #{value.inspect} to a ruby literal"
            else
              raise ArgumentError, "Invalid fallback option #{options[:fallback]}"
          end
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
        raise TypeSystem::InvalidValueLiteralError, "Invalid ruby value literal #{str.inspect}", ex.backtrace
      end

    end # module Methods
    extend(Methods)
    
  end # class Ruby
end # module TypeSystem