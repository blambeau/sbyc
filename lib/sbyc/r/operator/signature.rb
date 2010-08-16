require 'sbyc/r/operator/signature/factory'
module SByC
  module R
    class Operator
      class Signature
        extend(Factory)
        
        # Object used for unbounded signatures
        MATCHING_TERM = nil
        
        # Array of domains
        attr_reader :domains
        
        # Creates a signature instance
        def initialize(domains)
          @domains = domains
        end
        
        # Coerces some arguments to a signature
        def self.coerce(sign)
          case sign
            when Signature
              sign
            when ::Array
              Signature.new(sign)
            else
              raise ArgumentError, "Unable to coerce #{sign.inspect} #{sign.class} to a signature"
          end
        end
        
        # Checks if this signature matches a list of
        # domains
        def domain_matches?(domains, requester = nil)
          (self.domains.size == domains.size) &&
          self.domains.zip(domains).all?{|pair| 
            declared, actual = (pair[0] || requester), pair[1]
            actual.has_super_domain?(declared)
          }
        end

        # Does the signature matches some arguments?
        def arg_matches?(args, requester = nil)
          (self.domains.size == args.size) &&
          self.domains.zip(args).all?{|pair| (pair[0] || requester).is_value?(pair[1])}
        end
        
        # Makes an operator call on some arguments
        def make_operator_call(callable, args, &block)
          callable.call(*args, &block)
        end
        
      end # class Signature
    end # class Operator
  end # module R
end # module SByC
