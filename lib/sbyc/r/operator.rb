module SByC
  module R
    class Operator

      # Operator signature
      attr_reader :signature
      
      # Domain of the result
      attr_reader :result_domain
      
      # Creates an operator instance
      def initialize(signature, result_domain)
        @signature = signature
        @result_domain = result_domain
      end
      
      # Does the signature matches some arguments?
      def arg_matches?(args)
        return false unless signature.size == args.size
        signature.zip(args).all?{|pair|
          pair[0].is_value?(pair[1])
        }
      end
      
      # Does the signature matches another signature?
      def signature_matches?(args)
        return false unless signature.size == args.size
        signature.zip(args).all?{|pair|
          pair[0] == pair[1]
        }
      end
      
    end # class Operator
  end # module R
end # module SByC
require 'sbyc/r/operator/proc_operator'
require 'sbyc/r/operator/wrapped_operator'