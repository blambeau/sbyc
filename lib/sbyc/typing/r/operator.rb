module SByC
  module Typing
    module R
      class Operator

        # Operator signature
        attr_reader :signature
        
        # Operator returned type
        attr_reader :return_type
        
        # Creates an operator instance
        def initialize(signature, return_type)
          @signature = signature
          @return_type = return_type
        end
        
        # Does the signature matches some arguments?
        def matches?(args)
          return false unless signature.size == args.size
          signature.zip(args).all?{|pair|
            pair[0].is_value?(pair[1])
          }
        end
        
      end # class Operator
    end # module R
  end # module Typing
end # module SByC
require 'sbyc/typing/r/operator/proc_operator'
require 'sbyc/typing/r/operator/wrapped_operator'