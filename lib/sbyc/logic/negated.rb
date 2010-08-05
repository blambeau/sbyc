module Logic
  class Negated < Logic::Term
    
    def self.new(term)
      case term
        when All
          Logic::FALSE
        when None
          Logic::TRUE
        when BigOr
          BigAnd.new term.collect{|t| t.negation}
        when BigAnd
          BigOr.new  term.collect{|t| t.negation}
        when IntervalTerm
          IntervalTerm.new(term.name, term.interval.complement)
        when BelongsTo
          AllBut.new(term.name, term.values)
        when AllBut
          BelongsTo.new(term.name, term.values)
        else
          raise "Unexpected negation on #{term.class}"
      end
    end
    
  end # class Negated
end # module Logic