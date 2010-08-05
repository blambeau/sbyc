module Logic
  module Finite
    class FiniteTerm < Logic::Term
      
      # Referenced variable
      attr_reader :variable
      
      # Creates a term instance
      def initialize(variable)
        @variable = Variable::coerce(variable)
      end
      
    end # class FiniteTerm
  end # module Finite
end # module Logic