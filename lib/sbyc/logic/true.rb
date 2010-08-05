module Logic
  class True < Logic::Term
    
    def negation
      Logic::FALSE
    end
    
    def disjunction(term)
      self
    end
    
    def conjunction(term)
      term
    end
    
    def ==(other)
      other.kind_of?(True)
    end
    
    def to_s
      "true"
    end
    alias :inspect :to_s
    
  end # class True
end # module Logic