module SByC
  module R
    module AbstractDomain
      module Factory

        # Refines the domain with a sub domain
        def refine(*args)
          if args.size==1 and args[0].kind_of?(::Class)
            sub_domain = args[0]
            self.add_immediate_sub_domain(sub_domain)
            sub_domain.add_immediate_super_domain(self)
            sub_domain
          else
            refine(DomainDomain.create(args.shift, args))
          end
        end
        
      end # module Factory
    end # module AbstractDomain
  end # module R
end # module SByC
