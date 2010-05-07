module SByC
  class System
    # 
    # Operator signature
    #
    class Signature
  
      # Types of the arguments, in order
      attr_reader :arg_types
  
      # Creates a signature instance
      def initialize(arg_types)
        @arg_types = arg_types
      end
  
      #
      # Signature matching on types
      #
      # Returns true if this signature is applicable for _arguments_, false
      # otherwise.
      #
      def matches?(types)
        return false unless types.kind_of?(Array)
        return false unless (types.size == arg_types.size)
        arg_types.each_with_index do |expected, i|
          candidate = types[i]
          case expected 
            when Class
              return false unless ::SByC::System::is_ancestor_class?(expected, candidate)
            when Module
              return false unless candidate.include?(expected)
            else
              raise "Unexpected signature element #{expected}"
          end
        end
        true
      end
    
      #
      # Signature matching on values.
      #
      def ===(arguments)
        return false unless arguments.kind_of?(Array)
        return false unless (arguments.size == arg_types.size)
        matches?(arguments.collect{|c| c.class})
      end
  
      # Inspection
      def inspect
        "Signature(#{arg_types.inspect})"
      end
    
      # Coercion
      def self.coerce(arg)
        case arg
          when Signature
            arg
          when Module
            coerce([arg])
          when Array
            Signature.new(arg)
          else
            nil
        end
      end
  
    end # class Signature
  end # class System
end # module TypeSys