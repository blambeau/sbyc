class SByC::R::DomainGenerator::Array
  module ArrayDomain
      
    # Array of what?
    attr_accessor :of_domain
    
    # Returns domain name
    def domain_name
      "Array[#{of_domain.domain_name}]"
    end

    def exemplars
      [ coerce( [ 12 ] ) ]
    end

    def is_value?(value)
      (of = of_domain) &&
      value.kind_of?(::Array) && 
      value.all?{|v| of.is_value?(v)}
    end
  
    def parse_literal(literal)
      lit = literal.to_s.strip
      if lit =~ /^\[(.*)\]$/ 
        R::evaluate({}, "(Array #{$1})")
      elsif lit =~ /^\(Array (.*)\)$/
        R::evaluate({}, lit)
      else
        __not_a_literal__!(self, literal)
      end
    end
  
    def to_literal(value)
      literals = value.collect{|x| R::Alpha.domain_of(x).to_literal(x)}
      "(Array " + literals.join(', ') + ")"
    end
  
    def coerce(x)
      if is_value?(x)
        x
      elsif x.kind_of?(::Array)
        of = of_domain
        x.collect{|v| of.coerce(v)}
      elsif x.kind_of?(::String)
        parse_literal(x)
      else
        __not_a_literal__!(self, str)
      end
    end
    
  end # module ArrayDomain
end # class SByC::R::DomainGenerator::Array