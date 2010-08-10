module SByC
  module R
    module AbstractDomain
      module Domain
        include SByC::R::Robustness
        
        #######################################################################
        ### About itself
        #######################################################################
                
        # Returns the domain of this domain
        def domain
          R::Domain
        end
        alias :sbyc_domain :domain

        # Returns short name
        def short_name
          (name =~ /::([^:]+)$/) ? $1 : name
        end
        

    
        #######################################################################
        ### About sub domains
        #######################################################################
        
        # Returns known subdomains
        def sub_domains
          @sub_domains ||= []
        end

        # Adds a sub domain
        def add_sub_domain(subdomain)
          sub_domains << subdomain
          self
        end


      
        #######################################################################
        ### About superdomains
        #######################################################################
        
        # Returns known super domains
        def super_domains
          @super_domains ||= []
        end

        # Adds a super domain
        def add_super_domain(super_domain)
          super_domains << super_domain
          self
        end
        
        # Checks if a domain is a super domain of this one 
        def has_super_domain?(super_domain)
          if super_domains.include?(super_domain)
            true
          else
            super_domains.any?{|dom| dom.has_super_domain?(super_domain)}
          end
        end
        alias :sub_domain_of? :has_super_domain?
      

        #######################################################################
        ### About structures
        #######################################################################
        
        # Returns type structures
        def structures
          @structures ||= []
        end

        # Adds a structure
        def add_structure(structure)
          structures << structure
          self
        end
        
        # Checks if a domain has a given structure
        def has_structure?(structure)
          structures.include?(structure)
        end
      
      
      
        #######################################################################
        ### About coercion
        #######################################################################
        
        # Coerces from a ruby value
        def ruby_coerce(value)
          return value if is_value?(value)
          __not_a_valid_value__!(self, value)
        end
        
        # Coerces a value
        def coerce(value)
          if is_value?(value)
            return value
          elsif value.kind_of?(String) 
            str_coerce(value) 
          else
            ruby_coerce(value)
          end
        end
        
      end # module Domain
    end # module AbstractDomain
  end # module R
end # module SByC
