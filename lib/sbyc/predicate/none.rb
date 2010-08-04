module Predicate
  class None < Predicate::Term
    
    def negation
      Predicate::ALL
    end
    
    def disjunction(term)
      term
    end
    
    def conjunction(term)
      self
    end
    
    def ==(other)
      other.kind_of?(None)
    end
    
  end # class None
end # module Predicate