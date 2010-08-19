module SByC
  module R
    class DomainGenerator
      class Scalar < DomainGenerator
        
        def generate(name, heading)
          domain = factor_domain_class([Scalar::ScalarDomain])
          domain.heading = heading
          domain.domain_name = name
          domain
        end
        
        def refine(domain, *args)
          raise NotImplementedError, "Unable to refine array domains"
        end
        
      end # class Array
    end # class DomainGenerator
  end # module R
end # module SByC
require 'sbyc/r/domain_generator/scalar/scalar_domain'
