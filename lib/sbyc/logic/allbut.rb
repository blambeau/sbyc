module Logic
  class AllBut < Logic::Term
    include NamedTerm
    
    def self.new(name, values)
      if values.empty?
        Logic::ALL
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
      if term.kind_of?(AllBut) && term.name == name
        # not(in(x, y)) & not(in(y, z)) -> not(in(x,y) | in(y,z))
        #                               -> not(in(x,y | y,z))
        AllBut.new(name, (values | term.values))
      elsif term.kind_of?(BelongsTo) && term.name == name
        # not(in(x, y)) & in(y, z) -> in(y-z - x,y)
        #                          -> in(z)
        BelongsTo.new(name, (term.values - values))
      else
        super
      end
    end
    
    def disjunction(term)
      if term.kind_of?(AllBut) && term.name == name
        # not(in(x, y)) | not(in(y, z)) -> not(in(x, y) & in(y, z))
        #                               -> not(in(y))
        AllBut.new(name, values & term.values)
      elsif term.kind_of?(BelongsTo) && term.name == name
        # not(in(x,y)) | in(y,z) -> not(in(x,y) & not(in(y,z)))
        #                        -> not(in(x,y - y,z))
        AllBut.new(name, values - term.values)
      else
        super
      end
    end
    
    def negation
      BelongsTo.new(name, values)
    end
    
    def ==(other)
      other.kind_of?(AllBut) && 
      (other.name == name) &&
      (other.values.size == values.size) &&
      ((other.values & values) == values)
    end
    
    def to_s
      "#{name}: not(in(#{values.join(', ')}))"
    end
    alias :inspect :to_s
    
    
  end # class AllBut
end # module Logic
    
