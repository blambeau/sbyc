module SByC
  module R
    class DomainGenerator
      class Builtin < DomainGenerator
        
        def domain_name_of(domain)
          (domain.name.to_s =~ /^SByC::R::(.*)$/) ? $1 : domain.name.to_s
        end
        
        def domain_created(name, domain)
          # Install the selector
          if R::const_defined?(:Alpha)
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
        
        def generate(name, class_methods = [], instance_methods = [])
          domain = factor_domain_class(class_methods, instance_methods)
          domain_created(name, domain)
        end
        alias :[] :generate
        
        def refine(domain, *args)
          if args.size==1 and args[0].kind_of?(::Class)
            #
            # first case: the subdomain has already been created. Domain 
            # is probably a union domain ...
            #
            sub_domain = args[0]
            domain.add_immediate_sub_domain(sub_domain)
            sub_domain.add_immediate_super_domain(domain)
            sub_domain
          else
            #
            # Second case: a name and modules. Modules are split against
            # ClassMethods and InstanceMethods submodules. Module that do
            # not make the distinction are considered class modules.
            #
            name, modules = args.shift, args
            
            # split against ClassMethods/InstanceMethods distinction
            class_modules, instance_modules = [], []
            modules.each{|mod|
              if mod.const_defined?(:ClassMethods)
                class_modules << mod.const_get(:ClassMethods)
                if mod.const_defined?(:InstanceMethods)
                  instance_modules << mod.const_get(:InstanceMethods)
                end
              else
                class_modules << mod
              end
            }
            
            # create the domain and refine
            refine(domain, generate(name, class_modules, instance_modules))
          end
        end
        
      end # class Builtin
    end # class DomainGenerator
  end # module R
end # module SByC
require 'sbyc/r/domain_generator/builtin/alpha'
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
