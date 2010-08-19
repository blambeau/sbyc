module SByC::R::DomainGenerator::Tools
  module UnionDomain

    # Returns exemplars
    def exemplars
      immediate_sub_domains.collect{|dom| dom.exemplars}.flatten
    end
  
    # Returns true if a given value belongs to this domain,
    # false otherwise
    def is_value?(value)
      immediate_sub_domains.any?{|sub| sub.is_value?(value)}
    end

    # Parses a literal from the domain and returns
    # a value
    def parse_literal(str)
      immediate_sub_domains.each{|sub|
        begin
          return sub.parse_literal(str)
        rescue SByC::TypeError
        end
      }
      __not_a_literal__!(self, str)
    end

    # Converts a value to a literal
    def to_literal(value)
      sub = immediate_sub_domains.find{|sub| sub.is_value?(value)}
      sub ? sub.to_literal(value) : __not_a_literal__!(self, value)
    end
    
    # 
    # Acts as a Callable
    #
    def sbyc_call(runner, args, binding, &block)
      immediate_sub_domains.each{|sub|
        begin
          return sub.sbyc_call(runner, args, binding, &block)
        rescue SByC::SelectorInvocationError
        end
      }
      __selector_invocation_error__!(self, args)
    end

  end # module UnionDomain
end # module SByC::R::DomainGenerator::Tools
