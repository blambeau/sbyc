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
        reduce(term)
      end
    end
    
    # Computes boolean reduction
    def reduce(term)
      found = false
      new_terms = terms.collect{|t| 
        if t.reduces_bool_and?(term) 
          found = true
          t._bool_and(term)
        else
          t
        end
      }
      new_terms += [ term ] unless found
      normalize(new_terms)
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