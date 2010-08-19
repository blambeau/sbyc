module SByC
  module R
    class DomainGenerator
      class Array < DomainGenerator
        
        def initialize(system)
          super(system)
          @generated_by_subdomain = {}
        end
        
        def domain_name_of(domain)
          :"Array<#{domain.of_domain.domain_name}>"
        end
        
        def selector_signature(domain)
          R::Operator::Signature::star(system::Alpha)
        end
        
        def generate(name, sub_domain)
          @generated_by_subdomain[sub_domain] ||= do_generation(name, sub_domain)
        end
        
        def do_generation(name, sub_domain)
          domain = factor_domain_class([Array::ArrayDomain, Array::ArrayHierarchy])
          domain.of_domain = sub_domain
          domain
        end
        
        def refine(domain, *args)
          raise NotImplementedError, "Unable to refine array domains"
        end

        def sbyc_call(runner, args, binding)
          of_domain, = runner.ensure_args(args, [ [ runner.fed(:Domain) ] ], binding){
            runner.__domain_generation_error__!(self, args)
          }
          @generated_by_domain ||= make_generation(of_domain, runner)
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
