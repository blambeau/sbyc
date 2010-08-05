module Logic
  class Term
  
    def conjunction(right)
      if right.kind_of?(True)
        self
      elsif right.kind_of?(False)
        right
      else
        And.new(self, right)
      end
    end
  
    def disjunction(right)
      if right.kind_of?(True)
        right
      elsif right.kind_of?(False)
        self
      else
        Or.new(self, right)
      end
    end
  
    def negation
      Negated.new(self)
    end
  
  end # class Term
end # module Logic
