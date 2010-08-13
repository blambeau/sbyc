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
          res = @immediate_super_domains && (
            @immediate_super_domains.include?(super_domain) ||
            @immediate_super_domains.any?{|dom| dom.has_super_domain?(super_domain)}
          )
          !!res
        end
        alias :is_sub_domain_of? :has_super_domain?
      
        #
        # Returns true if this domain has known super domains, false otherwise.
        #
        def has_super_domains?
          res = @immediate_super_domains && !@immediate_super_domains.empty?
          !!res
        end
        
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
          res = @immediate_sub_domains && (
            @immediate_sub_domains.include?(sub_domain) ||
            @immediate_sub_domains.any?{|dom| dom.has_sub_domain?(sub_domain)}
          )
          !!res
        end
        alias :is_super_domain_of? :has_sub_domain?
      
        #
        # Returns true if this domain has known sub domains, false otherwise.
        #
        def has_sub_domains?
          res = @immediate_sub_domains && !@immediate_sub_domains.empty?
          !!res
        end
        
        #
        # Yields the block with each immediate sub domain.
        #
        def each_immediate_sub_domain(&block)
          @immediate_sub_domains.each(&block) if @immediate_sub_domains
        end

        #######################################################################
        ### Structures
        #######################################################################
        
        #
        # Returns true if the domain has a specific structure.
        #
        def has_structure?(structure)
          res = (@immediate_structure && 
           @immediate_structure.include?(structure)) ||
          (@immediate_super_domains &&
           @immediate_super_domains.any?{|dom| dom.has_structure?(structure)})
          !!res
        end

        #
        # Yields the block with each immediate structure.
        #
        def each_immediate_structure(&block)
          @immediate_structures.each(&block) if @immediate_structures
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

        #
        # Returns known immediate structures. This method builds an empty array
        # for structures as a side effect when not already done.
        #
        def immediate_structures
          @immediate_structures ||= []
        end

        #
        # Adds an immediate structure and returns self.
        #
        def add_immediate_structure(structure)
          immediate_structures << structure
          self
        end
        
      end # module Hierarchy
    end # module AbstractDomain 
  end # module R
end # module SByC