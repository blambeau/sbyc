require 'sbyc/r/operator/signature'
require 'sbyc/r/operator/aggregate_signature'
require 'sbyc/r/operator/set'
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

      # Creates an operator instance      
      def initialize
        yield(self) if block_given?
      end
      
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
        raise ArgumentError, "Invalid operator returns" unless returns.kind_of?(::Class)
        @returns = returns
      end

      # Sets operator aliases
      def aliases=(aliases)
        raise ArgumentError, "Invalid operator aliases" unless aliases.kind_of?(::Array)
        @aliases = aliases
      end

      # Sets operator method
      def method=(method)
        unless method.kind_of?(::Method) or 
               method.kind_of?(::UnboundMethod) or
               method.kind_of?(::Proc)
          raise ArgumentError, "Invalid operator method #{method} : #{method.class}" 
        end
        @method = method
      end
      
      #########################################################################
      ### Matching, type-checking and call
      #########################################################################
      
      # Does the signature matches some arguments?
      def arg_matches?(args, requester = nil)
        @signature.arg_matches?(args, requester)
      end
      
      # Does the signature matches another signature?
      def signature_matches?(args, requester = nil)
        @signature.domain_matches?(args, requester)
      end
      
      # Returns resulting domain when applied to a heading
      def result_domain_by_heading(args, requester = nil)
        self.returns || requester
      end

      # Call the operator
      def call(args, &block)
        signature.make_operator_call(method, args, &block)
      end
      
    end # class Operator
  end # module R
end # module SByC