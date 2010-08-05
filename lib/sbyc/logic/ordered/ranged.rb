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
    
      # Evaluates this formula on a context object
      # (typically a variable assignment)
      def evaluate(context)
        if context[variable.name].nil?
          raise SByC::NilError, "Missing variable #{variable.name}"
        end
        interval.contains?(context[variable.name])
      end
      
      # Computes equality with another term
      def ==(other)
        other.kind_of?(Ranged) && 
        (other.variable == variable) &&
        (other.interval == interval)
      end
    
      # Returns a string representation
      def to_s
        interval.to_ruby_code(variable.name.to_s)
      end
      alias :inspect :to_s
    
    end # class Ranged
  end # module Ordered
end # module Logic