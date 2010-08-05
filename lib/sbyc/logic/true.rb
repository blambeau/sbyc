module Logic
  class True < Logic::Term
    module Mimics; end 
    
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
    
    include Mimics
  end # class True
end # module Logic