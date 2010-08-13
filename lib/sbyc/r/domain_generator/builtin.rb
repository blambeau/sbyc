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
          domain_created(name, factor_domain_class(modules))
        end
        alias :[] :generate
        
      end # class Builtin
    end # class DomainGenerator
  end # module R
end # module SByC
require 'sbyc/r/domain_generator/builtin/alpha_domain'
require 'sbyc/r/domain_generator/builtin/domain'
require 'sbyc/r/domain_generator/builtin/expression'
require 'sbyc/r/domain_generator/builtin/boolean'
require 'sbyc/r/domain_generator/builtin/numeric'
require 'sbyc/r/domain_generator/builtin/integer'
require 'sbyc/r/domain_generator/builtin/float'
require 'sbyc/r/domain_generator/builtin/string'
require 'sbyc/r/domain_generator/builtin/time'
require 'sbyc/r/domain_generator/builtin/date'
require 'sbyc/r/domain_generator/builtin/symbol'
require 'sbyc/r/domain_generator/builtin/regexp'
require 'sbyc/r/domain_generator/builtin/module'
