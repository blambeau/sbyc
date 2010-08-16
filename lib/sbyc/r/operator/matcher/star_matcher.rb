module SByC
  module R
    class Operator
      class StarMatcher < Matcher
        
        # Creates a single matcher
        def initialize(delegate)
          @delegate = delegate
        end
        
        # Eats arguments
        def eat_args(args)
          r = []
          until (x = @delegate.eat_args(args)).nil? 
            r << x
          end
          r
        end
        
        # Eats on a signature
        def eat_signature(sign)
          r = []
          until (x = @delegate.eat_signature(sign)).nil? 
            r << x
          end
          r
        end
        
      end # class StarMatcher
    end # class Operator
  end # module R
end # module SByC