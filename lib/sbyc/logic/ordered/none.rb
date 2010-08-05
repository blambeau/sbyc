module Logic
  module Ordered
    class None < Ordered::OrderedTerm
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
  end # module Ordered
end # module Logic