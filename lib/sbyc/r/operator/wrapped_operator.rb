module SByC
  module R
    class WrappedOperator < R::Operator
      
      # Operator signature
      attr_reader :signature
      
      # Domain of the result
      attr_reader :result_domain
      
      # Implementation name
      attr_reader :impl
      
      # Creates an operator instance
      def initialize(signature, result_domain, impl)
        unless impl.kind_of?(::Symbol) or impl.kind_of?(::Proc)
          raise ArgumentError, "Unable to use #{impl.class} as operator implementation"
        end
        @signature = signature
        @result_domain = result_domain
        @impl = impl
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
      
      # Call the operator
      def call(args, &block)
        case impl
          when ::Symbol
            args.shift.send(impl, *args, &block)
          when ::Proc
            impl.call(args, &block)
          else
            raise SByC::Error, "Unable to use #{impl.class} as operator implementation"
        end
      end
      
    end # class WrappedOperator
  end # module R
end # module SByC