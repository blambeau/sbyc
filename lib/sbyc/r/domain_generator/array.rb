module SByC
  module R
    class DomainGenerator
      class Array < DomainGenerator
        
        def initialize(system)
          super(system)
          @generated_by_subdomain = {}
        end
        
        def refine(domain, *args)
          raise NotImplementedError, "Unable to refine array domains"
        end
        
        def call_signature(runner, args, binding)
          @call_signature ||= [ [ runner.fed(:Domain) ] ]
        end

        def coerce(runner, args, binding)
          of_domain = args.first
          @generated_by_subdomain[of_domain] ||= make_generation(of_domain, runner)
        end
        
        def make_generation(of_domain, runner)
          # Build the domain
          domain = factor_domain_class([Array::ArrayDomain, Array::ArrayHierarchy])
          domain.of_domain = of_domain
          domain
          
          # Make it a subdomain of Alpha if required
          alpha = runner.fed(:Alpha)
          if of_domain == alpha
            alpha.refine(domain)
          end
          
          # Return created domain
          domain
        end
        
      end # class Array
    end # class DomainGenerator
  end # module R
end # module SByC
require 'sbyc/r/domain_generator/array/array_domain'
require 'sbyc/r/domain_generator/array/array_hierarchy'
