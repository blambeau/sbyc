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

    # Computes boolean negation
    def bool_not
      Or.new(terms.collect{|t| t.bool_not})
    end
      
    # Computes boolean conjunction
    def _bool_and(term)
      new_terms = if term.kind_of?(And)
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
        if t.reduces_bool_and?(term)
          changed = true
          terms[i] = t._bool_and(term) 
        end
      }
      terms += [ term ] unless changed
      terms
    end
    
    # Normalizes terms
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
    
    # Evaluates this formula on a context object
    # (typically a variable assignment)
    def evaluate(context)
      terms.all?{|t| t.evaluate(context)}
    end
      
    # Implements equality
    def ==(other)
      other.kind_of?(And) &&
      (other.terms.size == self.terms.size) &&
      (other.terms.all?{|t| self.terms.include?(t)})
    end
    
    def to_s
      '(' + terms.join(' & ') + ')'
    end
    alias :inspect :to_s
    
  end # class And
end # module Logic