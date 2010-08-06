module SByC
  module Typing
    module R
      class ProcOperator < R::Operator
        
        # Creates an operator instance
        def initialize(signature, result_domain, proc)
          super(signature, result_domain)
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