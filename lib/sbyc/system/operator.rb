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
  
      # Type returned by the operators
      attr_reader :return_type
  
      # Ruby code to execute
      attr_reader :code
  
      # Creates an operator instance
      def initialize(name, signature, return_type, code)
        @name, @signature, @return_type, @code = name, signature, return_type, code
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
  
      # Inspection
      def inspect
        [name, signature, return_type].inspect
      end
  
    end # class Operator
  end # class System
end # module TypeSys