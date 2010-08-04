module Predicate
  class Negated < Predicate::Term
    
    def self.new(term)
      case term
        when All
          Predicate::NONE
        when None
          Predicate::ALL
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
end # module Predicate