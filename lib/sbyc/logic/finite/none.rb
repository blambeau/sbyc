module Logic
  module Finite
    class None < Finite::FiniteTerm
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
      
      def to_s
        "false"
      end
      alias :inspect :to_s
      
    end # class None
  end # module Finite
end # module Logic