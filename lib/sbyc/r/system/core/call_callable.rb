module SByC
  module R
    module System
      class Core
        class CallCallable
          include R::Callable
          
          def call_signature(runner, args, binding)
            @call_signature ||= [ [ ], [ ::Array ] ]
          end
          
          def coerce(runner, args, binding)
            who, arguments = args
            who = who.kind_of?(::Symbol) ? runner.fed(who) : who 
            runner.__assert_callable__!(who).sbyc_call(runner, arguments, {})
          end
          
        end # class CallCallable
      end # class Core
    end # module System
  end # module R
end # module SByC