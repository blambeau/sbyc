module SByC
  module R
    class Operator
      class Signature
        
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
            when Array
              Signature.new(sign)
            else
              raise ArgumentError, "Unable to coerce #{sign.inspect} to a signature"
          end
        end
        
        def self.aggregate(domain)
          AggregateSignature.new(domain)
        end
        
        # Checks if this signature matches a list of
        # domains
        def domain_matches?(domains)
          (self.domains.size == domains.size) &&
          self.domains.zip(domains).all?{|pair| 
            declared, actual = pair
            (actual == declared) || (actual.has_super_domain?(declared))
          }
        end

        # Does the signature matches some arguments?
        def arg_matches?(args)
          (self.domains.size == args.size) &&
          self.domains.zip(args).all?{|pair| pair[0].is_value?(pair[1])}
        end
        
        # Makes an operator call on some arguments
        def make_operator_call(callable, args, &block)
          callable.call(*args, &block)
        end
        
      end # class Signature
    end # class Operator
  end # module R
end # module SByC
