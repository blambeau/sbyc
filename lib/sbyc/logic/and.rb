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
      elsif reducer_and_index = find_reducer_and_index(term)
        new_terms = terms.dup
        new_terms[reducer_and_index[1]] = reducer_and_index[0]._bool_and(term)
        normalize(new_terms)
      else
        And.new(terms + [ term ])
      end
    end
    
    def find_reducer_and_index(term)
      terms.each_with_index{|t,i|
        return [t, i] if t.reduces_bool_and?(term)
      }
      nil
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