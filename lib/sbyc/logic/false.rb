module Logic
  class False < Logic::Term
    
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
    
    def to_s
      "false"
    end
    alias :inspect :to_s
    
  end # class False
end # module Logic