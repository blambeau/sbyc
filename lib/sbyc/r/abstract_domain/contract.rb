module SByC
  module R
    module AbstractDomain
      module Contract

        # Name of this domain inside a runner
        attr_accessor :sbyc_name

        #######################################################################
        ### About the domain generator and delegation to it
        #######################################################################
        
        #
        # Sets the domain generator.
        #
        # This method is considered private and should be used by the generator
        # only!
        #
        def domain_generator=(generator)
          @domain_generator = generator
        end
        
        #
        # Returns the generator that created this domain.
        #
        # @return [DomainGenerator] a generator instance
        #
        def domain_generator
          @domain_generator
        end
        
        # 
        # Returns the system under which this domain runs
        #
        def system
          @domain_generator.system
        end
        
        #
        # Returns the domain name.
        #
        # @return [String] domain's name
        #
        def domain_name
          @sbyc_name ||= @domain_generator.domain_name_of(self)
        end
        
        #
        # Refines the domain.
        #
        # @see DomainGenerator#refine
        #
        def refine(*args)
          @domain_generator.refine(self, *args)
        end
        
    
        #######################################################################
        ### About domain's domain and values
        #######################################################################
 
        # 
        # Returns the domain of the domain. Most probably the answer should 
        # be R::Domain.
        #
        # @return [Class] a SByC domain value, represented physically by a ruby 
        #          class and respecting the present contract
        #
        # @post Returned value is such that <code>R::Domain.is_value?(returned)</code>
        #       is true
        #
        def sbyc_domain
          system.fed(:Domain)
        end
        
        #
        # Returns an array with domain exemplars. Complex domains are allowed 
        # to return an empty array.
        #
        # @returns [Array<Object>] an array of exemplars
        #
        # @post Returned exemplars should be such that <code>is_value?(exemplar)</code>
        #      is true.
        #
        def exemplars
          raise NotImplementedError, "Class #{self} should implement exemplars"
        end

        #
        # Returns true if value belongs to this domain, false otherwise.
        #
        # @param [Object] value any ruby object
        # @return [true|false] true if the value belongs to the domain, 
        #         false otherwise
        #
        # @post when true is returned, it implicitely means that all methods 
        #      taking value as arguments should work without raising exception 
        #      (is_value?, to_literal, ...)
        #
        def is_value?(value)
          raise NotImplementedError, "Class #{self} should implement is_value?"
        end
      
        #######################################################################
        ### About literals and coercion
        #######################################################################
 
        # 
        # Parses a literal and returns a value belonging to this domain.
        #
        # @param [String] literal a string literal.
        # @return [Object] a value of the domain if the literal is valid.
        # @raise TypeError if the literal is not valid for the domain.
        # @post Returned value is such that <code>is_value?(returned)</code>
        #       is true.
        #
        def parse_literal(literal)
          raise NotImplementedError, "Class #{self} should implement parse_literal"
        end
      
        # 
        # Converts a value to a valid R expression, whose evaluation returns
        # value.
        #
        # @param [Object] value a value belonging to this domain.
        # @return [String] a R expression as a string, such that its evaluation
        #         would return the same value.
        #
        # @pre Expression <code>is_value?(value)</code> is true
        # @post Returned value is such that <code>parse_literal(returns) == value</code>
        #       is true.
        #
        def to_literal(value)
          raise NotImplementedError, "Class #{self} should implement to_literal"
        end
      
      end # module Contract
    end # module AbstractDomain
  end # module R
end # module SByC
