module SByC
  module R
    module AbstractDomain
      module Factory

        # Refines the domain with a sub domain
        def refine(*args)
          if args.size==1 and args[0].kind_of?(::Class)
            # first case, the domain has already been created
            sub_domain = args[0]
            self.add_immediate_sub_domain(sub_domain)
            sub_domain.add_immediate_super_domain(self)
            sub_domain
          else
            # second case a name and modules
            name, modules = args.shift, args
            class_modules, instance_modules = [], []
            
            # split all modules
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
            refine(DomainDomain.create(name, class_modules, instance_modules))
          end
        end
        
      end # module Factory
    end # module AbstractDomain
  end # module R
end # module SByC
