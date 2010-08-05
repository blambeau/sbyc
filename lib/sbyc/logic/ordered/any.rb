module Logic
  module Ordered
    class Any < Ordered::OrderedTerm
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
  end # module Ordered
end # module Logic