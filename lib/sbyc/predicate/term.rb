module Predicate
  class Term
  
    def conjunction(right)
      if right.kind_of?(All)
        self
      elsif right.kind_of?(None)
        right
      else
        BigAnd.new(self, right)
      end
    end
  
    def disjunction(right)
      if right.kind_of?(All)
        right
      elsif right.kind_of?(None)
        self
      else
        BigOr.new(self, right)
      end
    end
  
    def negation
      Negated.new(self)
    end
  
  end # class Term
end # module Predicate
