module SByC
  module R
    module System
      class Core
        class DefCallable
          include R::Callable
          
          def call_signature(runner, args, binding)
            @call_signature ||= [ [::Symbol], [] ]
          end
          
          def coerce(runner, args, binding)
            runner.def(*args)
          end
          
        end # class DefCallable
      end # class Core
    end # module System
  end # module R
end # module SByC