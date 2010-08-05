module Logic
  module Ordered
    class None < Ordered::OrderedTerm
      include Logic::False::Mimics
      
      # Computes boolean negation
      def bool_not
        Any.new(variable)
      end
      
      # Computes boolean conjunction
      def bool_and(term)
        self
      end
      
      # Computes boolean disjunction
      def bool_or(term)
        term
      end
      
      # Compares with another term
      def ==(other)
        other.kind_of?(None) and other.variable == variable
      end
      
    end # class None
  end # module Ordered
end # module Logic