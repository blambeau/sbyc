module Logic
  module Finite
    class BelongsTo < Finite::FiniteTerm
    
      # Included values
      attr_reader :values
    
      # Creates a BelongsTo instance
      def initialize(variable, values)
        super(variable)
        @values = values
      end
    
      # Computes boolean conjunction
      def _bool_and(term)
        case term
          when AllBut
            term.bool_and(self)
          when BelongsTo
            # in(x,y) & in(y,z) -> in(x,y & y,z)
            Finite::belongs_to(variable, (values & term.values))
          else
            raise "Unexpected term #{term.class}"
        end
      end
    
      # Computes boolean disjunction
      def _bool_or(term)
        case term
          when AllBut
            term.bool_or(self)
          when BelongsTo
            # in(x,y) | in(y,z) -> in(x,y | y,z)
            Finite::belongs_to(variable, (values | term.values))
          else
            raise "Unexpected term #{term.class}"
        end
      end
    
      # Computes boolean negation
      def bool_not
        Finite::allbut(variable, values)
      end
    
      # Checks equality with another term
      def ==(other)
        other.kind_of?(BelongsTo) && 
        (other.variable == variable) &&
        (other.values.size == values.size) &&
        ((other.values & values) == values)
      end
    
      # Returns a string representation
      def to_s
        "#{variable}: in(#{values.join(', ')})"
      end
      alias :inspect :to_s
    
    end # class BelongsTo
  end # module Finite
end # module Logic
    
