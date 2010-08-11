require 'sbyc/r/operator/signature'
require 'sbyc/r/operator/aggregate_signature'
module SByC
  module R
    class Operator
      
      # Operator's description
      attr_reader :description
      
      # Operator's signature
      attr_reader :signature
      
      # Operator's argument names
      attr_reader :argnames
      
      # Operator's returned domain
      attr_reader :returns
      
      # Operator's aliases
      attr_reader :aliases
      
      # Ruby method implementing the operator
      attr_reader :method
      
      #########################################################################
      ### Setters
      #########################################################################
      
      # Sets operator description
      def description=(str)
        raise ArgumentError, "Invalid operator description #{str.class}" unless str.kind_of?(::String)
        @description = str
      end
      
      # Sets operator signature
      def signature=(sign)
        @signature = Signature::coerce(sign)
      end
      
      # Sets operator argument names
      def argnames=(names)
        raise ArgumentError, "Invalid operator argnames" unless names.kind_of?(::Array)
        @argnames = names
      end
      
      # Sets operator return type
      def returns=(returns)
        raise ArgumentError, "Invalid operator returns" unless R::domain_of(returns) == R::Domain
        @returns = returns
      end

      # Sets operator aliases
      def aliases=(aliases)
        raise ArgumentError, "Invalid operator aliases" unless aliases.kind_of?(::Array)
        @aliases = aliases
      end

      # Sets operator method
      def method=(method)
        raise ArgumentError, "Invalid operator method" unless method.kind_of?(::Method)
        @method = method
      end
      
      #########################################################################
      ### Matching, type-checking and call
      #########################################################################
      
      # Does the signature matches some arguments?
      def arg_matches?(args)
        @signature.arg_matches?(args)
      end
      
      # Does the signature matches another signature?
      def signature_matches?(args)
        @signature.domain_matches?(args)
      end
      
      # Returns resulting domain when applied to a heading
      def result_domain_by_heading(args)
        self.returns
      end

      # Call the operator
      def call(args, &block)
        signature.make_operator_call(method, args, &block)
      end
      
    end # class Operator
  end # module R
end # module SByC
require 'sbyc/r/operator/wrapped_operator'
require 'sbyc/r/operator/aggregate_operator'