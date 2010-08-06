module SByC
  module Typing
    module R
      class WrappedOperator < R::Operator
        
        # Method name
        attr_reader :method
        
        # Creates an operator instance
        def initialize(signature, return_type, method)
          super(signature, return_type)
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