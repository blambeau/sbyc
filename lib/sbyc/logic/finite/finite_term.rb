module Logic
  module Finite
    class FiniteTerm < Logic::Term
      
      # Referenced variable
      attr_reader :variable
      
      # Creates a term instance
      def initialize(variable)
        @variable = Variable::coerce(variable)
      end
      
      # Returns true if a given term can be reduced
      # on bool_and
      def reduces_bool_and?(term)
        term.kind_of?(FiniteTerm) and term.variable == variable
      end
      
      # Returns true if a given term can be reduced
      # on bool_or
      def reduces_bool_or?(term)
        term.kind_of?(FiniteTerm) and term.variable == variable
      end

    end # class FiniteTerm
  end # module Finite
end # module Logic