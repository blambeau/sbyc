module SByC
  module R
    class DomainGenerator
      
      # System under which this generator is installed
      attr_reader :system
      
      def initialize(system)
        @system = system
      end
      
      def populate_class(clazz, class_methods = [], instance_methods = [])
        class_methods.flatten.each{|mod| 
          clazz.extend(mod)
        }
        instance_methods.flatten.each{|mod|
          clazz.instance_eval{ include(mod) }
        }
        clazz
      end
      
      def factor_class(class_methods = [], instance_methods = [])
        populate_class(Class.new, class_methods, instance_methods)
      end
      
      def split_domain_modules(modules)
        class_modules, instance_modules = [], []
        modules.flatten.each{|mod|
          if mod.const_defined?(:ClassMethods)
            class_modules << mod.const_get(:ClassMethods)
            if mod.const_defined?(:InstanceMethods)
              instance_modules << mod.const_get(:InstanceMethods)
            end
          else
            class_modules << mod
          end
        }
        [class_modules, instance_modules]
      end
      
      def factor_domain_class(modules)
        clazz = factor_class(*split_domain_modules([R::AbstractDomain]+modules))
        clazz.domain_generator = self
        clazz
      end
      
      def refine(domain, sub_domain)
        domain.add_immediate_sub_domain(sub_domain)
        sub_domain.add_immediate_super_domain(domain)
        sub_domain
      end
        
      def call_error(runner, args, binding)
        runner.__domain_generation_error__!(self, args)
      end
        
      def sbyc_call(runner, args, binding)
        args = runner.ensure_args(args, call_signature(runner, args, binding), binding){
          runner.__domain_generation_error__!(self, args)
        }
        coerce(runner, args, binding)
      end
        
    end # class DomainGenerator
  end # module R
end # module SByc
require 'sbyc/r/domain_generator/tools'
require 'sbyc/r/domain_generator/builtin'
require 'sbyc/r/domain_generator/array'
require 'sbyc/r/domain_generator/scalar'
