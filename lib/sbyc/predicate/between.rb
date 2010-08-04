module Predicate
  class Between < Predicate::Term
    include NamedTerm
    
    attr_reader :name
    attr_reader :interval
    
    def self.new(name, interval)
      if interval.empty?
        Predicate::NONE
      elsif interval.all?
        Predicate::ALL
      else
        super
      end
    end
    
    def initialize(name, interval)
      @name, @interval = name, interval
    end
    
    def negation
      Between.new(name, interval.complement)
    end
    
    def disjunction(term)
      if term.kind_of?(Between) and term.name == name
        Between.new(name, interval.union(term.interval))
      else
        super
      end
    end
    
    def conjunction(term)
      if term.kind_of?(Between) and term.name == name
        Between.new(name, interval.intersection(term.interval))
      else
        super
      end
    end
    
  end # class Negated
end # module Predicate