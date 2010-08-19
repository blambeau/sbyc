module SByC
  module R
    module AbstractDomain
      module Callable
        
        def call_error(runner, args, binding)
          runner.__selector_invocation_error__!(self, args)
        end
        
        def ensure_call_args(runner, args, binding)
          args = runner.ensure_args(args, call_signature, binding){
            call_error(runner, args, binding)
          }
          yield(args)
        end
        
        def sbyc_call(runner, args, binding)
          ensure_call_args(runner, args, binding){|coerced| 
            coerce(runner, coerced, binding)
          }
        end
        
      end # module Callable
    end # module AbstractDomain
  end # module R
end # module SByC