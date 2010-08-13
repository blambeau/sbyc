class SByC::R::DomainGenerator::Array
  module ArrayHierarchy
    
    # This seems required because of the way ruby deals with module 
    # inclusion
    include SByC::R::AbstractDomain::Hierarchy
    
    #######################################################################
    ### Super domains
    #######################################################################
    
    def has_super_domain?(super_domain)
      if domain_generator == super_domain.domain_generator
        self.of_domain.has_super_domain?(super_domain.of_domain)
      else
        super
      end
    end
    alias :is_sub_domain_of? :has_super_domain?
  
    def each_immediate_super_domain(&block)
      # TODO: this is semantically incorrect as hierarchy of arrays is not
      # kept in cache. Implementing this naively would generate to many domains.
      # The current implementation remains correct as long as Array operators are 
      # defined on Array<Alpha> itself.
      block.call(R::Array)
    end
    
    #######################################################################
    ### Sub domains
    #######################################################################
    
    def has_sub_domain?(sub_domain)
      if domain_generator == super_domain.domain_generator
        self.of_domain.has_sub_domain?(super_domain.of_domain)
      else
        super
      end
    end
    alias :is_super_domain_of? :has_sub_domain?
  
    def each_immediate_sub_domain(&block)
      # TODO: this is semantically incorrect as hierarchy of arrays is not
      # kept in cache. Implementing this naively would generate to many domains.
      # The current implementation remains correct as long as Array operators are 
      # defined on Array<Alpha> itself.
      super
    end

  end # module ArrayHierarchy
end # class SByC::R::DomainGenerator::Array