module Logic
  module FalseLike
    
    def bool_not
      Logic::TRUE
    end
    
    def bool_and(term)
      self
    end
    
    def bool_or(term)
      term
    end
    
    def ==(other)
      other.kind_of?(False)
    end
    
    def evaluate(context)
      false
    end
  
    def to_s
      "false"
    end
    alias :inspect :to_s
    
  end # module FalseLike
  class False < Logic::Term
    include FalseLike
  end
end # module Logic