module SByC
  module R
    class AggregateOperator < R::Operator
      
      # Operator operand type
      attr_reader :operand_domain
      
      # Neutral value
      attr_reader :neutral_value
      
      # Implementation
      attr_reader :impl
      
      # Creates an operator instance
      def initialize(operand_domain, neutral_value, impl)
        unless impl.kind_of?(::Symbol) or impl.kind_of?(::Proc)
          raise ArgumentError, "Unable to use #{impl.class} as operator implementation"
        end
        @operand_domain = operand_domain
        @neutral_value = neutral_value
        @impl = impl
      end
      
      # Does the signature matches some arguments?
      def arg_matches?(args)
        args.all?{|arg| operand_domain.is_value?(arg)}
      end
      
      # Does the signature matches another signature?
      def signature_matches?(args)
        args.all?{|arg|
          (operand_domain == arg) || (arg.has_super_domain?(operand_domain))
        }
      end
      
      # Returns resulting domain when applied to a heading
      def result_domain_by_heading(args)
        R::Alpha::most_specific_domain_of(neutral_value)
      end
      
      # Call the operator
      def call(args, &block)
        args.inject(neutral_value){|memo, arg|
          case impl
            when ::Symbol
              memo.send(impl, arg, &block)
            when ::Proc
              impl.call(memo, arg, &block)
            else
              raise SByC::Error, "Unable to use #{impl.class} as operator implementation"
          end
        }
      end
      
    end # class AggregateOperator
  end # module R
end # module SByC