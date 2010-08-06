module SByC
  module Typing
    module R
      module System
      
        #######################################################################
        ### About domains
        #######################################################################
      
        # Returns the domains
        def domains
          [ R::Domain ] + R::Domain.prinstine_domains
        end
      
        # Ensures a domain on x
        def coerce_domain!(x)
          R::Domain::coerce(x)
        end
        
        # Does a given value looks a domain
        def looks_a_domain?(x)
          x.kind_of?(Class) and x.ancestors.include?(R::Domain)
        end
        
        # Does a given value looks a prinstine domain
        def looks_a_prinstine_domain?(x)
          looks_a_domain?(x) and !(x == R::Domain)
        end
        
        # Returns the domain of a value
        def domain_of(value)
          if value.respond_to?(:sbyc_domain)
            return value.sbyc_domain
          else
            coerce_domain!(value.class)
          end
        end
        alias :type_of :domain_of
      
        #######################################################################
        ### About literals
        #######################################################################
        
        # Converts a value to a literal
        def to_literal(value)
          domain_of(value).to_literal(value)
        end
      
        # Parses a literal
        def parse_literal(literal)
          domains.each{|d| 
            begin
              return d.parse_literal(literal)
            rescue SByC::TypeError
            end
          }
          __not_a_literal__!(self, literal)
        end
        
        #######################################################################
        ### About coercions
        #######################################################################
        
        # Coerces a value
        def coerce(value, domain = nil)
          if domain.nil?
            coerce_domain!(value.class).coerce(value)
          else
            coerce_domain!(domain).coerce(value)
          end
        end
      
        #######################################################################
        ### About operators
        #######################################################################
        
        # Returns an operator for a given name and signature
        def find_operator_by_signature(name, signature)
          signature[0].find_operator_by_signature(name, signature)
        end
        
        # Returns an operator for a given name and args
        def find_operator_by_args(name, args)
          find_operator_by_signature(name, args.collect{|arg| domain_of(arg)})
        end
        
      end # module System
    end # module R
  end # module Typing
end # module SByC