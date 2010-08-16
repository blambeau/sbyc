module SByC
  module R
    module AbstractDomain
      module Hierarchy
        
        #######################################################################
        ### Super domains
        #######################################################################
        
        #
        # Returns true if super_domain is a super domain of self, false otherwise.
        #
        # @param [Class] super_domain a domain value. 
        # @return [true|false] true if _super_domain_ is a super domain, false 
        #         otherwise.
        #
        # @pre <code>R::Domain.is_value(super_domain)</code> is true
        #
        def has_super_domain?(super_domain)
          return true if (self == super_domain)
          res = @immediate_super_domains && (
            @immediate_super_domains.include?(super_domain) ||
            @immediate_super_domains.any?{|dom| dom.has_super_domain?(super_domain)}
          )
          !!res
        end
        alias :is_sub_domain_of? :has_super_domain?
        
        def has_proper_super_domain?(super_domain)
          (self != super_domain) && has_super_domain?(super_domain)
        end
        alias :is_proper_sub_domain_of? :has_proper_super_domain?
      
        #
        # Yields the block with each immediate super domain.
        #
        def each_immediate_super_domain(&block)
          @immediate_super_domains.each(&block) if @immediate_super_domains
        end
        
        #######################################################################
        ### Sub domains
        #######################################################################
        
        #
        # Returns true if sub_domain is a sub domain of self, false otherwise.
        #
        # @param [Class] sub_domain a domain value. 
        # @return [true|false] true if _sub_domain_ is a sub domain, false 
        #         otherwise.
        #
        # @pre <code>R::Domain.is_value(sub_domain)</code> is true
        #
        def has_sub_domain?(sub_domain)
          return true if (self == sub_domain)
          res = @immediate_sub_domains && (
            @immediate_sub_domains.include?(sub_domain) ||
            @immediate_sub_domains.any?{|dom| dom.has_sub_domain?(sub_domain)}
          )
          !!res
        end
        alias :is_super_domain_of? :has_sub_domain?
      
        def has_proper_sub_domain?(sub_domain)
          (self != sub_domain) && has_sub_domain?(super_domain)
        end
        alias :is_proper_super_domain_of? :has_proper_sub_domain?
        
        #
        # Yields the block with each immediate sub domain.
        #
        def each_immediate_sub_domain(&block)
          @immediate_sub_domains.each(&block) if @immediate_sub_domains
        end

        #######################################################################
        ### Private section
        #######################################################################
        
        #
        # Returns known immediate subdomains. This method builds an empty array
        # for sub domains as a side effect when not already done.
        #
        def immediate_sub_domains
          @immediate_sub_domains ||= []
        end
        
        #
        # Adds an immediate sub domain and returns self.
        #
        def add_immediate_sub_domain(subdomain)
          immediate_sub_domains << subdomain
          self
        end
        
        #
        # Returns known immediate superdomains. This method builds an empty array
        # for super domains as a side effect when not already done.
        #
        def immediate_super_domains
          @immediate_super_domains ||= []
        end
        
        #
        # Adds an immediate sub domain and returns self.
        #
        def add_immediate_super_domain(superdomain)
          immediate_super_domains << superdomain
          self
        end
        
      end # module Hierarchy
    end # module AbstractDomain 
  end # module R
end # module SByC