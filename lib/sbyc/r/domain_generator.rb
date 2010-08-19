module SByC
  module R
    class DomainGenerator
      
      # System under which this generator is installed
      attr_reader :system
      
      # Creates a generator for a given system
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
      
      # Factors a class with class methods and instance methods
      def factor_class(class_methods = [], instance_methods = [])
        populate_class(Class.new, class_methods, instance_methods)
      end
      
      # Split domain modules against ClassMethods/InstanceMethods
      # separation.
      def split_domain_modules(modules)
        # split against ClassMethods/InstanceMethods distinction
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
      
      # Factors a domain class
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
        
    end # class DomainGenerator
  end # module R
end # module SByc
require 'sbyc/r/domain_generator/tools'
require 'sbyc/r/domain_generator/builtin'
require 'sbyc/r/domain_generator/array'
require 'sbyc/r/domain_generator/scalar'
