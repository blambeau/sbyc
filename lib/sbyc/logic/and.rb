module Logic
  class And < Logic::Formula
    
    # Creates an And instance
    def initialize(terms)
      @terms = terms
    end
    
    # Computes boolean conjunction
    def bool_and(term)
      if term.bool_and_neutral?
        self
      elsif term.bool_and_absorber?
        Logic::FALSE
      else
        super
      end
    end
    
  end # class And
end # module Logic