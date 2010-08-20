module SByC::R::DomainGenerator::Tools
  module UnionDomain

    def exemplars
      immediate_sub_domains.collect{|dom| dom.exemplars}.flatten
    end
  
    def is_value?(value)
      immediate_sub_domains.any?{|sub| sub.is_value?(value)}
    end

    def parse_literal(str)
      immediate_sub_domains.each{|sub|
        begin
          return sub.parse_literal(str)
        rescue SByC::TypeError
        end
      }
      __not_a_literal__!(self, str)
    end

    def to_literal(value)
      sub = immediate_sub_domains.find{|sub| sub.is_value?(value)}
      sub ? sub.to_literal(value) : __not_a_literal__!(self, value)
    end
    
    def sbyc_call(runner, args, binding)
      call_error(runner, args, binding)
    end

  end # module UnionDomain
end # module SByC::R::DomainGenerator::Tools
