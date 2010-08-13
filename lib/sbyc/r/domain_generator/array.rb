module SByC
  module R
    class DomainGenerator
      class Array < DomainGenerator
        
        def domain_name_of(domain)
          "Array<#{domain.of_domain.domain_name}>"
        end
        
        def domain_created(name, domain)
          of_domain = domain.of_domain
          if of_domain == R::Alpha
            op = R::Operator.new{|op|
              op.description = %Q{ Selector for #{name} }
              op.signature   = SByC::R::aggregate_signature(of_domain)
              op.argnames    = [:operands]
              op.returns     = domain
              op.aliases     = [:Array]
              op.method      = lambda{|x| x.collect{|x| of_domain.coerce(x)}}
            }
            of_domain::Operators.add_operator(op)
          end
          super
        end
        
        def generate(sub_domain)
          domain = factor_domain_class([Array::ArrayDomain])
          domain.of_domain = sub_domain
          domain_created(domain_name_of(domain), domain)
        end
        
        def refine(domain, *args)
          raise NotImplementedError, "Unable to refine array domains"
        end
        
      end # class Array
    end # class DomainGenerator
  end # module R
end # module SByC
require 'sbyc/r/domain_generator/array/array_domain'
