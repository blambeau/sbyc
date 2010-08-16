module SByC
  module R
    class Operator
      class SeqMatcher < Matcher
        
        # Creates a single matcher
        def initialize(delegates)
          @delegates = delegates
        end
        
        # Eats arguments
        def eat_args(args, requester)
          @delegates.collect{|d| 
            matched = d.eat_args(args, requester)
            return nil if matched.nil?
            matched
          }
        end
        
        # Eats on a signature
        def eat_signature(sign, requester)
          @delegates.collect{|d| 
            matched = d.eat_signature(sign, requester)
            return nil if matched.nil?
            matched
          }
        end
        
      end # class SeqMatcher
    end # class Operator
  end # module R
end # module SByC