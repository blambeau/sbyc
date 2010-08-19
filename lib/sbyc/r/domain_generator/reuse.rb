module SByC
  module R
    class DomainGenerator
      class Reuse < DomainGenerator
        
        def generate(name, clazz)
          populate_class(clazz, [R::AbstractDomain, Tools::ReuseDomain])
          clazz.domain_name = name
          clazz.domain_generator = self
          clazz
        end
        
      end # class Builtin
    end # class DomainGenerator
  end # module R
end # module SByC
