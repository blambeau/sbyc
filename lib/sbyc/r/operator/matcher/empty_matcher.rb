module SByC
  module R
    class Operator
      class EmptyMatcher < Matcher
        
        # Rewrites arguments for a method call
        def prepare_args_for_call(args)
          args.empty? ? [] : nil
        end
      
        # Eats arguments
        def eat_args(args)
          []
        end
        
        # Eats on a signature
        def eat_signature(sign)
          []
        end
        
      end # class EmptyMatcher
    end # class Operator
  end # module R
end # module SByC