module SByC
  module R
    class DomainGenerator
      class Builtin < DomainGenerator
        
        #
        # Returns the signature to use for the selector of a given
        # domain.
        #
        # @returns [Signature] a signature.
        #
        def selector_signature(domain)
          R::Operator::Signature.single(system::Alpha)
        end
        
        def domain_name_of(domain)
          # TODO: remove this R 
          (domain.name.to_s =~ /^SByC::R::(.*)$/) ? $1.to_sym : domain.name.to_s.to_sym
        end
        
        def generate(name, modules = [])
          modules = [ self.class.const_get(:"#{name}Domain") ] + modules
          factor_domain_class(modules)
        end
        
      end # class Builtin
    end # class DomainGenerator
  end # module R
end # module SByC
require 'sbyc/r/domain_generator/builtin/alpha_domain'
require 'sbyc/r/domain_generator/builtin/domain_domain'
require 'sbyc/r/domain_generator/builtin/boolean_domain'
require 'sbyc/r/domain_generator/builtin/numeric_domain'
require 'sbyc/r/domain_generator/builtin/integer_domain'
require 'sbyc/r/domain_generator/builtin/float_domain'
require 'sbyc/r/domain_generator/builtin/string_domain'
require 'sbyc/r/domain_generator/builtin/time_domain'
require 'sbyc/r/domain_generator/builtin/date_domain'
require 'sbyc/r/domain_generator/builtin/symbol_domain'
require 'sbyc/r/domain_generator/builtin/regexp_domain'
require 'sbyc/r/domain_generator/builtin/heading_domain'
require 'sbyc/r/domain_generator/builtin/expression_domain'
require 'sbyc/r/domain_generator/builtin/module_domain'
