module SByC
  module R
    module Callable
      module SignatureBased
        include Callable
        
        def arity
          @arity ||= call_signature.size
        end
      
        def sbyc_call(runner, args, binding)
          coerce(runner, args, binding)
        end

      end # module AstBased
    end # module Callable
  end # module R
end # module SByC