module SByC
  module R
    module Callable
      
      def works_on_ast?
        false
      end
      
      def call_error(runner, args, binding)
        runner.__signature_mistmatch__!(self, args)
      end
      
    end # module Callable
  end # module R
end # module SByC
require 'sbyc/r/callable/ast_based'
require 'sbyc/r/callable/signature_based'