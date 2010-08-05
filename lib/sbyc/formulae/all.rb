module Formulae
  class All < Formulae::Term
    
    def negation
      Formulae::NONE
    end
    
    def disjunction(term)
      self
    end
    
    def conjunction(term)
      term
    end
    
    def ==(other)
      other.kind_of?(All)
    end
    
    def to_s
      "all"
    end
    alias :inspect :to_s
    
  end # class All
end # module Formulae