module Logic
  class Formula

    # Returns true if a given term can be reduced
    # on bool_and, false otherwise
    def reduces_bool_and?(term)
      false
    end
    
    # Returns true if a given term can be reduced
    # on bool_or, false otherwise
    def reduces_bool_or?(term)
      false
    end
      
    # Is this formula equivalent to boolean true?
    def bool_true?
      self.kind_of?(Logic::True::Mimics)
    end

    # Is this formula equivalent to boolean false?
    def bool_false?
      self.kind_of?(Logic::False::Mimics)
    end

    # Computes boolean and
    def bool_and(right)
      if self.bool_true?
        # true and right -> right
        right
      elsif right.bool_true?
        # left and true -> left
        self
      elsif self.bool_false?
        # false and right -> false
        Logic::FALSE
      elsif right.bool_false?
        # left and false -> false
        Logic::FALSE
      elsif self.reduces_bool_and?(right)
        self._bool_and(right)
      elsif right.reduces_bool_and?(self)
        right._bool_and(self)
      else 
        And.new([self, right])
      end
    end
  
    # Computes boolean or
    def bool_or(right)
      if self.bool_true?
        # true or right -> true
        Logic::TRUE
      elsif right.bool_true?
        # left or true -> true
        Logic::TRUE
      elsif self.bool_false?
        # false or right -> right
        right
      elsif right.bool_false?
        # left or false -> left
        self
      elsif self.reduces_bool_or?(right)
        self._bool_or(right)
      elsif right.reduces_bool_or?(self)
        right._bool_or(self)
      else 
        Or.new([self, right])
      end
    end
  
    # Computes boolean not
    def bool_not
      if self.bool_true?
        Logic::FALSE
      elsif self.bool_false?
        Logic::TRUE
      else
        raise NotImplementedError
      end
    end
    
    # Evaluates this formula on a context object
    # (typically a variable assignment)
    def evaluate(context)
      raise NotImplementedError
    end
  
  end # class Formula
end # module Logic