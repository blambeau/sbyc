module SByC
  module R
    class DomainGenerator
      class Array < DomainGenerator
        
        def domain_name_of(domain)
          "Array<#{domain.of_domain.domain_name}>"
        end
        
        #
        # Returns the signature to use for the selector of a given
        # domain.
        #
        # @returns [Signature] a signature.
        #
        def selector_signature(domain)
          R::Operator::AggregateSignature.new(R::Alpha)
        end
        
        def generate(name, sub_domain)
          domain = factor_domain_class([Array::ArrayDomain])
          domain.of_domain = sub_domain
          domain
        end
        
        def refine(domain, *args)
          raise NotImplementedError, "Unable to refine array domains"
        end
        
      end # class Array
    end # class DomainGenerator
  end # module R
end # module SByC
require 'sbyc/r/domain_generator/array/array_domain'
