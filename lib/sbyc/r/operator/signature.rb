require "enumerator"
require "sbyc/r/operator/signature/factory"
module SByC
  module R
    class Operator
      class Signature
        extend(Signature::Factory)
        
        # Matcher
        attr_reader :matcher
        
        def self.coerce(x)
          Signature.new(Matcher.coerce(x))
        end
        
        # Creates a regular signature
        def initialize(matcher)
          @matcher = matcher
        end

        # Prepars arguments for a call
        def prepare_args_for_call(args, requester = nil)
          matcher.prepare_args_for_call(args, requester)
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
          call_args = prepare_args_for_call(args, nil)
          matcher.call_with_star? ? callable.call(*call_args) : callable.call(call_args)
        end
        
        def +(other)
          Signature.new(SeqMatcher.new([matcher, other.matcher]))
        end

        def to_s
          "(Signature #{matcher.to_s})"
        end

      end # class Signature
    end # class Operator
  end # module R
end # module SByC
