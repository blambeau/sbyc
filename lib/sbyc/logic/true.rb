module Logic
  module TrueLike
    
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
    
    def evaluate(context)
      true
    end
  
    def to_s
      "true"
    end
    alias :inspect :to_s
    
  end # class True
  class True < Logic::Term
    include TrueLike
  end
end # module Logic