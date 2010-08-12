module SByC
  module R
    module AbstractDomain
      module Factory

        # Refines the domain with a sub domain
        def immediate_refine(sub_domain)
          self.add_immediate_sub_domain(sub_domain)
          sub_domain.add_immediate_super_domain(self)
          sub_domain
        end
        
      end # module Factory
    end # module AbstractDomain
  end # module R
end # module SByC
