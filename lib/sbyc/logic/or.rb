module Logic
  class Or < Logic::Formula
    
    attr_reader :terms
    
    # Creates an Or instance
    def initialize(terms)
      @terms = terms
    end
    
    # Returns true if a given term can be reduced
    # on bool_or
    def reduces_bool_or?(term)
      true
    end
      
    # Computes boolean disjunction
    def _bool_or(term)
      new_terms = if term.kind_of?(Or)
        term.terms.inject(terms.dup){|memo, t| reduce_terms_with(memo, t)}
      else
        reduce_terms_with(terms.dup, term)
      end
      normalize(new_terms)
    end
    
    # Computes boolean reduction
    def reduce_terms_with(terms, term)
      changed = false
      terms.each_with_index{|t,i|
        if t.reduces_bool_or?(term)
          changed = true
          terms[i] = t._bool_or(term) 
        end
      }
      terms += [ term ] unless changed
      terms
    end
    
    # Normalizes terms
    def normalize(terms)
      if terms.any?{|t| t.bool_true?}
        Logic::TRUE
      else
        terms.delete_if{|t| t.bool_false?}
        case terms.size
          when 0
            Logic::FALSE
          when 1
            terms[0]
          else
            Or.new(terms)
        end
      end
    end
    
    # Implements equality
    def ==(other)
      other.kind_of?(Or) &&
      (other.terms.size == self.terms.size) &&
      (other.terms.all?{|t| self.terms.include?(t)})
    end
    
    def to_s
      terms.join(' | ')
    end
    alias :inspect :to_s
    
  end # class Or
end # module Logic