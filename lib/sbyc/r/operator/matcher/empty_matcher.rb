module SByC
  module R
    class Operator
      class EmptyMatcher < Matcher
        
        # Rewrites arguments for a method call
        def prepare_args_for_call(args, requester = nil)
          args.empty? ? [] : nil
        end
      
        def at(index)
          self
        end
        
        # Eats arguments
        def eat_args(args, requester)
          []
        end
        
        # Eats on a signature
        def eat_signature(sign, requester)
          []
        end
        
        def ==(other)
          other.kind_of?(EmptyMatcher)
        end
        
      end # class EmptyMatcher
    end # class Operator
  end # module R
end # module SByC