module SByC
  module R
    class Operator
      
      # Operator's description
      attr_accessor :description
      
      # Operator's signature
      attr_accessor :signature
      
      # Operator's argument names
      attr_accessor :argnames
      
      # Operator's returned domain
      attr_accessor :returns
      
      # Operator's aliases
      attr_accessor :aliases
      
      # Ruby method implementing the operator
      attr_accessor :method
      
      # Does the signature matches some arguments?
      def arg_matches?(args)
        (signature.size == args.size) &&
        signature.zip(args).all?{|pair| pair[0].is_value?(pair[1])}
      end
      
      # Does the signature matches another signature?
      def signature_matches?(args)
        (signature.size == args.size) &&
        signature.zip(args).all?{|pair| declared, actual = pair;
          (actual == declared) || (actual.has_super_domain?(declared))
        }
      end
      
      # Returns resulting domain when applied to a heading
      def result_domain_by_heading(args)
        self.returns
      end

      # Call the operator
      def call(args, &block)
        method.call(*args, &block)
      end
      
    end # class Operator
  end # module R
end # module SByC
require 'sbyc/r/operator/wrapped_operator'
require 'sbyc/r/operator/aggregate_operator'