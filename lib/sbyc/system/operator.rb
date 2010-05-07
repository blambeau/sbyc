module SByC
  class System
    #
    # Typed operator with a name, signature and return type.
    #
    class Operator
  
      # Operator's name
      attr_reader :name

      # Operator's signature
      attr_reader :signature
  
      # Ruby code to execute
      attr_reader :code
  
      # Creates an operator instance
      def initialize(name, signature, code)
        raise ArgumentError unless signature.kind_of?(::SByC::System::Signature) 
        @name, @signature, @code = name, signature, code
      end
    
      # Compiles this operator call to ruby code
      def to_ruby_code(system = nil, arguments = [])
        case arguments.size
          when 0
            code
          else
            size, the_code = arguments.size, code.dup
            (0...size).to_a.reverse.each{|i| 
              the_code.gsub!(/[$]#{i}/, arguments[i])
            }
            the_code
        end
      end
      
      # Returns the type returned by this operator
      def return_type(*args)
        signature.return_type(*args)
      end
  
      # Inspection
      def inspect
        [name, signature].inspect
      end
  
    end # class Operator
  end # class System
end # module SByC