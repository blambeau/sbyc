class SByC::R::DomainGenerator::Array
  module ArrayDomain
      
    # Array of what?
    attr_accessor :of_domain
    
    def domain_name
      @sbyc_name ||= :"Array<#{of_domain.domain_name}>"
    end
    
    def exemplars
      if of_domain == system.fed(:Alpha)
        [ [ true, 12, [ "hello" "world" ] ] ]
      else
        [ of_domain.exemplars ]
      end
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
      literals = value.collect{|x| system.fed(:Alpha).domain_of(x).to_literal(x)}
      "[" + literals.join(', ') + "]"
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
        __not_a_literal__!(self, x)
      end
    end
    
    def sbyc_call(runner, args, binding)
      args = args.collect{|arg| 
        runner.ensure_arg(arg, [ of_domain ], binding){
          runner.__selector_invocation_error__!(self, args)
        }
      }
      args
    end
    
  end # module ArrayDomain
end # class SByC::R::DomainGenerator::Array