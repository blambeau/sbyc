module Formulae
  class Between < Formulae::Term
    include NamedTerm
    
    attr_reader :name
    attr_reader :interval
    
    def self.new(name, interval)
      if interval.empty?
        Formulae::NONE
      elsif interval.all?
        Formulae::ALL
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
    
    def ==(other)
      other.kind_of?(Between) && 
      (other.name == name) &&
      (other.interval == interval)
    end
    
    def to_s
      "#{name}: #{interval}"
    end
    alias :inspect :to_s
    
  end # class Negated
end # module Formulae