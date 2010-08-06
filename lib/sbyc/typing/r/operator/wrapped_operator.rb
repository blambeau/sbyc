module SByC
  module Typing
    module R
      class WrappedOperator < R::Operator
        
        # Method name
        attr_reader :method
        
        # Creates an operator instance
        def initialize(signature, result_domain, method)
          super(signature, result_domain)
          @method = method
        end
        
        # Call the operator
        def call(args, &block)
          args.shift.send(method, *args)
        end
        
      end # class Operator
    end # module R
  end # module Typing
end # module SByC