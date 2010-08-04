module Predicate
  class All < Predicate::Term
    
    def negation
      Predicate::NONE
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
    
  end # class All
end # module Predicate