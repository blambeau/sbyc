module Logic
  module Ordered
    class OrderedTerm < Logic::Term
      
      # Referenced variable
      attr_reader :variable
      
      # Creates a term instance
      def initialize(variable)
        @variable = Variable::coerce(variable)
      end
      
    end # class OrderedTerm
  end # module Ordered
end # module Logic