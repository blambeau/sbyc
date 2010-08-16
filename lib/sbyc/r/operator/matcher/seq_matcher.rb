module SByC
  module R
    class Operator
      class SeqMatcher < Matcher
        
        attr_reader :delegates
        
        def self.exemplars
          [ SeqMatcher.new([DomainMatcher.new(system::String), DomainMatcher.new(system::Integer)]) ]
        end
      
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
        
        def to_s
          "(Matcher #{@delegates.join(', ')})"
        end
        
        def ==(other)
          other.kind_of?(SeqMatcher) && other.delegates == @delegates
        end
        
        protected :delegates
      end # class SeqMatcher
    end # class Operator
  end # module R
end # module SByC