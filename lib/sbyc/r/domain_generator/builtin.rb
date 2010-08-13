module SByC
  module R
    class DomainGenerator
      class Builtin < DomainGenerator
        
        def domain_name_of(domain)
          (domain.name.to_s =~ /^SByC::R::(.*)$/) ? $1 : domain.name.to_s
        end
        
        def domain_created(name, domain)
          unless name == :Alpha
            op = R::Operator.new{|op|
              op.description = %Q{ Selector for #{name} }
              op.signature   = [SByC::R::Alpha]
              op.argnames    = [:operand]
              op.returns     = domain
              op.aliases     = [name]
              op.method      = lambda{|x| domain.coerce(x)}
            }
            R::Alpha::Operators.add_operator(op)
          end
          super
        end
        
        def generate(name, modules = [])
          if modules.empty?
            modules = [ self.class.const_get("#{name}Domain".to_sym) ]
            raise "Unable to find #{name}Domain" if modules.empty?
          end
          domain_created(name, factor_domain_class(modules))
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
