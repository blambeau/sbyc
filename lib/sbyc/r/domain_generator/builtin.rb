module SByC
  module R
    class DomainGenerator
      class Builtin < DomainGenerator
        
        def domain_name_of(domain)
          (domain.name.to_s =~ /^SByC::R::(.*)$/) ? $1 : domain.name.to_s
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
require 'sbyc/r/domain_generator/builtin/expression_domain'
require 'sbyc/r/domain_generator/builtin/boolean_domain'
require 'sbyc/r/domain_generator/builtin/numeric_domain'
require 'sbyc/r/domain_generator/builtin/integer_domain'
require 'sbyc/r/domain_generator/builtin/float_domain'
require 'sbyc/r/domain_generator/builtin/string_domain'
require 'sbyc/r/domain_generator/builtin/time_domain'
require 'sbyc/r/domain_generator/builtin/date_domain'
require 'sbyc/r/domain_generator/builtin/symbol_domain'
require 'sbyc/r/domain_generator/builtin/regexp_domain'
require 'sbyc/r/domain_generator/builtin/module_domain'
