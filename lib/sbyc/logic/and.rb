module Logic
  class And < Logic::Formula
    
    attr_reader :terms
    
    # Creates an And instance
    def initialize(terms)
      @terms = terms
    end
    
    # Returns true if a given term can be reduced
    # on bool_and
    def reduces_bool_and?(term)
      true
    end
      
    # Computes boolean conjunction
    def _bool_and(term)
      if term.kind_of?(And)
        raise NotImplementedError
      else
        normalize(reduce_terms_with(terms.dup, term))
      end
    end
    
    # Computes boolean reduction
    def reduce_terms_with(terms, term)
      changed = false
      terms.each_with_index{|t,i|
        if t.reduces_bool_and?(term)
          changed = true
          terms[i] = t._bool_and(term) 
        end
      }
      terms += [ term ] unless changed
      terms
    end
    
    def normalize(terms)
      if terms.any?{|t| t.bool_false?}
        Logic::FALSE
      else
        terms.delete_if{|t| t.bool_true?}
        case terms.size
          when 0
            Logic::TRUE
          when 1
            terms[0]
          else
            And.new(terms)
        end
      end
    end
    
  end # class And
end # module Logic