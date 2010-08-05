module Logic
  module Ordered
    class Any < Ordered::OrderedTerm
      
      # Computes boolean negation
      def bool_not
        None.new(variable)
      end
      
      # Computes boolean conjunction
      def bool_and(term)
        term
      end
      
      # Computes boolean disjunction
      def bool_or(term)
        self
      end
      
      # Compares with another term
      def ==(other)
        other.kind_of?(Any) and other.variable == variable
      end
      
    end # class Any
  end # module Ordered
end # module Logic