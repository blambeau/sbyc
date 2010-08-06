module SByC
  module Typing
    module R
      class ProcOperator < R::Operator
        
        # Creates an operator instance
        def initialize(signature, return_type, proc)
          super(signature, return_type)
          @proc = proc
        end
        
        # Call the operator
        def call(args, &block)
          @proc.call(*args, &block)
        end
        
      end # class ProcOperator
    end # module R
  end # module Typing
end # module SByC