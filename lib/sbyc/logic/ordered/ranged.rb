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
      def bool_and(term)
        if term.kind_of?(Ordered::OrderedTerm) and term.variable == variable
          case term
            when Any
              self
            when None
              term
            when Ranged
              Ordered::ranged(variable, interval.intersection(term.interval))
            else
              super
          end
        else
          super
        end
      end
    
      # Computes boolean disjunction
      def bool_or(term)
        if term.kind_of?(Ordered::OrderedTerm) and term.variable == variable
          case term
            when Any
              term
            when None
              self
            when Ranged
              Ordered::ranged(variable, interval.union(term.interval))
            else
              super
          end
        else
          super
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