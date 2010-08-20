module SByC
  module R
    class DomainGenerator
      class Builtin < DomainGenerator
        
        def call_signature(runner, args, binding)
          args.size == 1 ? [ [ ::Symbol ] ] : [ [ ::Symbol ], [ ::Class ] ]
        end
        
        def coerce(runner, args, binding)
          name, super_domain = args

          # Build the domain
          modules = [ self.class.const_get(:"#{name}Domain") ]
          domain = factor_domain_class(modules)
          
          # Applies refinement is required
          unless super_domain.nil?
            super_domain.refine(domain)
          end
          
          # Return created domain
          domain
        end
        
      end # class Builtin
    end # class DomainGenerator
  end # module R
end # module SByC
require 'sbyc/r/domain_generator/builtin/ast_domain'
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
require 'sbyc/r/domain_generator/builtin/macro_domain'
require 'sbyc/r/domain_generator/builtin/operator_domain'
