module SByC
  module R
    class DomainGenerator
      class Reuse < DomainGenerator
        
        def selector_signature(domain)
          R::Operator::Signature.plus(system::Alpha)
        end
        
        def domain_name_of(domain)
          # TODO: remove this R 
          (domain.name.to_s =~ /^SByC::R::(.*)$/) ? $1.to_sym : domain.name.to_s.to_sym
        end
        
        def generate(name, clazz)
          populate_class(clazz, [R::AbstractDomain, Tools::ReuseDomain])
          clazz.domain_name = name
          clazz.domain_generator = self
          clazz
        end
        
      end # class Builtin
    end # class DomainGenerator
  end # module R
end # module SByC
