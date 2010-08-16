require "enumerator"
module SByC
  module R
    class Operator
      class RegularSignature < Signature
        
        # Matcher
        attr_reader :matcher
        
        # Creates a regular signature
        def initialize(matcher)
          @matcher = matcher
        end

        # Prepars arguments for a call
        def prepare_args_for_call(args)
          matcher.prepare_args_for_call(args)
        end
        
        # Checks if this signature matches a list of
        # domains
        def domain_matches?(domains, requester = nil)
          matcher.domain_matches?(domains, requester)
        end

        # Does the signature matches some arguments?
        def arg_matches?(args, requester = nil)
          matcher.args_matches?(args, requester)
        end
        
        # Makes an operator call on some arguments
        def make_operator_call(callable, args, &block)
          call_args = prepare_args_for_call(args)
          matcher.call_with_star? ? callable.call(*call_args) : callable.call(call_args)
        end
        
        def +(other)
          RegularSignature.new(SeqMatcher.new([matcher, other.matcher]))
        end

      end # class RegularSignature
    end # class Operator
  end # module R
end # module SByC
