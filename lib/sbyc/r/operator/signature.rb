require "enumerator"
require "sbyc/r/operator/signature/factory"
module SByC
  module R
    class Operator
      class Signature
        extend(Signature::Factory)
        
        # Matcher
        attr_reader :matcher
        
        # Argument names
        attr_reader :arg_names
        
        def self.coerce(x)
          arg_names, matchers = [], []
          x.each_slice(2){|name, matcher|
            arg_names << name
            matchers  << matcher 
          }
          Signature.new(Matcher.coerce(matchers), arg_names)
        end
        
        # Creates a regular signature
        def initialize(matcher, arg_names = nil)
          @matcher = matcher
          @arg_names = arg_names
        end
        
        # Set names of the arguments
        def arg_names=(names)
          @arg_names = names
        end
        
        # Returns the matcher for a given name
        def matcher_for(name)
          index = arg_names.index(name)
          matcher.at(index)
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
          unless arg_names
            "(Signature #{matcher.to_s})"
          else
            buffer = "(Signature"
            arg_names.each_with_index{|name, i|
              buffer << " " << name.inspect 
              buffer << " " << matcher.at(i).to_s(true)
            }
            buffer << ")"
            buffer
          end
        end

      end # class Signature
    end # class Operator
  end # module R
end # module SByC
