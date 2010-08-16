module SByC
  module R
    class Operator
      class StarMatcher < Matcher
        
        attr_reader :delegate
        
        def self.exemplars
          [ StarMatcher.new(DomainMatcher.new(system::String)) ]
        end
      
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
          r
        end
        
        # Eats on a signature
        def eat_signature(sign, requester)
          r = []
          until (x = @delegate.eat_signature(sign, requester)).nil? 
            r << x
          end
          r
        end
        
        def to_s
          "(* #{@delegate.to_s})"
        end
        
        def ==(other)
          other.kind_of?(StarMatcher) && other.delegate == @delegate
        end
        
        protected :delegate
      end # class StarMatcher
    end # class Operator
  end # module R
end # module SByC