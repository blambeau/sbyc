module Logic
  class Formula

    def bool_true?
      self.kind_of?(Logic::True::Mimics)
    end

    def bool_false?
      self.kind_of?(Logic::False::Mimics)
    end

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
        And.new(self, right)
      end
    end
  
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
        Or.new(self, right)
      end
    end
  
    def bool_not
      raise NotImplementedError
    end
  
  end # class Formula
end # module Logic