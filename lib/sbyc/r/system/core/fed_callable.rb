module SByC
  module R
    module System
      class Core
        class FedCallable
          include R::Callable
          
          def call_signature(runner, args, binding)
            @call_signature ||= [ [::Symbol] ]
          end
          
          def coerce(runner, args, binding)
            runner.fed(*args)
          end
          
        end # class FedCallable
      end # class Core
    end # module System
  end # module R
end # module SByC
    