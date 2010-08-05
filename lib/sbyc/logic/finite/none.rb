module Logic
  module Finite
    class None < Finite::FiniteTerm
      include Logic::FalseLike
      
      # Computes boolean negation
      def bool_not
        Any.new(variable)
      end
      
      # Compares with another term
      def ==(other)
        other.kind_of?(None) and other.variable == variable
      end
      
    end # class None
  end # module Finite
end # module Logic