module Logic
  module Ordered
    class Ranged < Ordered::OrderedTerm
    
      # Underlying interval
      attr_reader :interval
    
      # Creates a Ranged instance
      def initialize(variable, interval)
        super(variable)
        @interval = interval
      end
    
      # Computes boolean negation
      def bool_not
        Ranged.new(variable, interval.complement)
      end
    
      # Computes boolean conjunction
      def _bool_and(term)
        case term
          when Ranged
            Ordered::ranged(variable, interval.intersection(term.interval))
          else
            raise "Unexpected term #{term.class}"
        end
      end
    
      # Computes boolean disjunction
      def _bool_or(term)
        case term
          when Ranged
            Ordered::ranged(variable, interval.union(term.interval))
          else
            raise "Unexpected term #{term.class}"
        end
      end
    
      # Computes equality with another term
      def ==(other)
        other.kind_of?(Ranged) && 
        (other.variable == variable) &&
        (other.interval == interval)
      end
    
      # Returns a string representation
      def to_s
        "#{variable}: #{interval}"
      end
      alias :inspect :to_s
    
    end # class Ranged
  end # module Ordered
end # module Logic