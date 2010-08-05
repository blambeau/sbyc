module Logic
  class And < Logic::Term
    
    attr_reader :terms
    
    # Are terms normalized?
    def self.normalized?(terms)
      names = terms.select{|t| Logic::NamedTerm === t}.collect{|n| n.name}
      names == names.uniq
    end
    
    def self.new(*terms)
      terms = terms.flatten.uniq.delete_if{|v| v == Logic::ALL}
      if terms.empty?
        Logic::ALL
      elsif terms.size == 1
        terms.first
      elsif terms.include?(Logic::NONE)
        Logic::NONE
      elsif terms.any?{|v| v.kind_of?(And)}
        ands, others = terms.partition{|term| term.kind_of?(And)}
        self.new(ands.collect{|a| a.terms}.flatten + others)
      elsif normalized?(terms)
        super(terms)
      else
        named, others = terms.partition{|term| Logic::NamedTerm === term}
        hash = Hash.new{|h,k| h[k] = Logic::ALL}
        named.each{|n| hash[n.name] = hash[n.name].conjunction(n)}
        named = hash.keys.sort{|k1, k2| k1.to_s <=> k2.to_s}.collect{|k| hash[k]}
        self.new(named + others)
      end
    end
    
    def initialize(terms)
      @terms = terms
    end
    
    def ==(other)
      other.kind_of?(And) &&
      other.terms == terms
    end
    
    def to_s
      terms.join(' and ') + ' (AND)'
    end
    alias :inspect :to_s
    
  end # class And
end # module Logic