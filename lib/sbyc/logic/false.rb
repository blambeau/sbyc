module Logic
  class False < Logic::Term
    
    def negation
      Logic::TRUE
    end
    
    def disjunction(term)
      term
    end
    
    def conjunction(term)
      self
    end
    
    def ==(other)
      other.kind_of?(False)
    end
    
    def to_s
      "false"
    end
    alias :inspect :to_s
    
  end # class False
end # module Logic