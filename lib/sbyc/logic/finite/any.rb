module Logic
  module Finite
    class Any < Finite::FiniteTerm
      include Logic::TrueLike
      
      # Computes boolean negation
      def bool_not
        None.new(variable)
      end
      
      # Compares with another term
      def ==(other)
        other.kind_of?(Any) and other.variable == variable
      end
      
    end # class Any
  end # module Finite
end # module Logic