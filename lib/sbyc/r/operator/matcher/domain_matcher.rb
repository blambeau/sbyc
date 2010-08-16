module SByC
  module R
    class Operator
      class DomainMatcher < Matcher
        
        # Creates a single matcher
        def initialize(domain)
          @domain = domain
        end
        
        # Rewrites arguments for a method call
        def prepare_args_for_call(args, requester = nil)
          x = eat_args(args, requester)
          (x.nil? || !args.empty?) ? nil : [ x ]
        end
      
        # Eats arguments
        def eat_args(args, requester)
          if args.size >= 1 && @domain.is_value?(args.first)
            args.shift
          else
            nil
          end
        end
        
        # Eats on a signature
        def eat_signature(sign, requester)
          if sign.size >= 1 && @domain.is_super_domain_of?(sign.first)
            sign.shift
          else
            nil
          end
        end
        
      end # class DomainMatcher
    end # class Operator
  end # module R
end # module SByC