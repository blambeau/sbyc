module SByC
  module R
    class Operator
      class PlusMatcher < Matcher
        
        # Creates a single matcher
        def initialize(delegate)
          @delegate = delegate
        end
        
        def call_with_star?
          false
        end
      
        # Eats arguments
        def eat_args(args, requester)
          r = []
          until (x = @delegate.eat_args(args, requester)).nil? 
            r << x
          end
          r.empty? ? nil : r
        end
        
        # Eats on a signature
        def eat_signature(sign, requester)
          r = []
          until (x = @delegate.eat_signature(sign, requester)).nil? 
            r << x
          end
          r.empty? ? nil : r
        end
        
      end # class PlusMatcher
    end # class Operator
  end # module R
end # module SByC