module Logic
  module Finite
    class Any < Finite::FiniteTerm
      include Logic::True::Mimics
      
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
  end # module Finite
end # module Logic