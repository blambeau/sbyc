module Logic
  class None < Logic::Term
    
    def negation
      Logic::ALL
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
    
    def to_s
      "none"
    end
    alias :inspect :to_s
    
  end # class None
end # module Logic