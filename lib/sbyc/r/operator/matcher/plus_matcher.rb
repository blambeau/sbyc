module SByC
  module R
    class Operator
      class PlusMatcher < Matcher
        
        attr_reader :delegate
        
        def self.exemplars
          [ PlusMatcher.new(DomainMatcher.new(system::String)) ]
        end
      
        # Creates a single matcher
        def initialize(delegate)
          @delegate = delegate
        end
        
        def at(index)
          self
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
        
        def to_s(enclosed = false)
          case delegate
            when DomainMatcher
              "#{@delegate.to_s(true)}+" 
            else
              "(+ #{@delegate.to_s(true)})"
          end
        end
        alias :inspect :to_s
        
        def ==(other)
          other.kind_of?(PlusMatcher) && other.delegate == @delegate
        end
        
        protected :delegate
      end # class PlusMatcher
    end # class Operator
  end # module R
end # module SByC