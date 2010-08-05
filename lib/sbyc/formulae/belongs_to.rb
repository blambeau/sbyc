module Formulae
  class BelongsTo < Formulae::Term
    include NamedTerm
    
    def self.new(name, values)
      if values.empty?
        Formulae::NONE
      else
        super(name, values.uniq)
      end
    end
    
    attr_reader :name
    
    attr_reader :values
    
    def initialize(name, values)
      @name = name
      @values = values
    end
    
    def conjunction(term)
      if term.kind_of?(BelongsTo) && term.name == name
        # in(x,y) & in(y,z) -> in(x,y & y,z)
        BelongsTo.new(name, (values & term.values))
      elsif term.kind_of?(AllBut) && term.name == name
        term.conjunction(self)
      else
        super
      end
    end
    
    def disjunction(term)
      if term.kind_of?(BelongsTo) && term.name == name
        # in(x,y) | in(y,z) -> in(x,y | y,z)
        BelongsTo.new(name, (values | term.values))
      elsif term.kind_of?(AllBut) && term.name == name
        term.disjunction(self)
      else
        super
      end
    end
    
    def negation
      AllBut.new(name, values)
    end
    
    def ==(other)
      other.kind_of?(BelongsTo) && 
      (other.name == name) &&
      (other.values.size == values.size) &&
      ((other.values & values) == values)
    end
    
    def to_s
      "#{name}: in(#{values.join(', ')})"
    end
    alias :inspect :to_s
    
  end # class BelongsTo
end # module Formulae
    
