module Logic
  class True < Logic::Term
    
    def bool_not
      Logic::FALSE
    end
    
    def bool_and(term)
      term
    end
    
    def bool_or(term)
      self
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