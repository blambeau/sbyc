module SByC
  module R
    module AbstractDomain
      module Contract

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
        # Returns the signature to use for the selector.
        #
        # @returns [Signature] a signature.
        #
        def selector_signature
          @domain_generator.selector_signature(self)
        end
 
        #
        # Returns the domain name.
        #
        # @return [String] domain's name
        #
        def domain_name
          @domain_generator.domain_name_of(self)
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
          R::Domain
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
          raise NotImplementedError
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
          raise NotImplementedError
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
          raise NotImplementedError
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
          raise NotImplementedError
        end
      
        # 
        # Coerces an object _x_ to a value of the domain. 
        #
        # @param [Object] x any object. 
        # @return [Object] a value of the domain.
        # @raise TypeError if _x_ cannot be coerced to this domain.
        #
        # @post Returned value is such that <code>is_value?(returned)</code> 
        #       is true
        #
        def coerce(x)
          if is_value?(x)
            x
          elsif x.kind_of?(::String)
            parse_literal(x)
          else
            __not_a_literal__!(self, x)
          end
        end
        
        #######################################################################
        ### About operators
        ###
        ### Following methods relies on the following additional methods to
        ### be implemented by concrete domains:
        ###   - each_immediate_structure
        ###   - each_immediate_super_domain
        ###
        #######################################################################
 
        #
        # Finds an operator by signature
        #
        def find_operator_by_signature(name, signature, requester = self)
          # first case: a matching operator exists in domain own operators
          op = self::Operators::find_operator_by_signature(name, signature, requester)
          return op unless op.nil?
        
          # third case: a matching operator exists in a structure
          each_immediate_structure{|struct|
            op = struct.find_operator_by_signature(name, signature, requester)
            return op unless op.nil?
          }
        
          # second case: a matching operator exists in a super domain
          each_immediate_super_domain{|dom|
            op = dom.find_operator_by_signature(name, signature, requester)
            return op unless op.nil?
          }
        
          # nothing found
          nil
        end

        # Finds an operator by arguments
        def find_operator_by_args(name, args, requester = self)
          # first case: a matching operator exists in domain own operators
          op = self::Operators::find_operator_by_args(name, args, requester)
          return op unless op.nil?
        
          # third case: a matching operator exists in a structure
          each_immediate_structure{|struct|
            op = struct.find_operator_by_args(name, args, requester)
            return op unless op.nil?
          }
        
          # second case: a matching operator exists in a super domain
          each_immediate_super_domain{|dom|
            op = dom.find_operator_by_args(name, args, requester)
            return op unless op.nil?
          }
        
          # nothing found
          nil
        end
        
      end # module Contract
    end # module AbstractDomain
  end # module R
end # module SByC
