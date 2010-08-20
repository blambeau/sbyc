module SByC
  module R
    module System
      class Core
        class RubySendCallable
          include R::Callable::SignatureBased
          
          def call_signature(runner, args, binding)
            @call_signature ||= [ [::Symbol ], [ ] ]
          end
          
          def sbyc_call(runner, args, binding)
            method, receiver = runner.ensure_args(args[0..1], call_signature(runner, args, binding), binding){
              call_error(runner, args, binding)
            }
            call_args = args[2..-1].collect{|arg| runner.ensure_arg(arg, [], binding)}
            if call_args.last.class == runner.fed(:Expression)
              proc = call_args.last.to_ruby_proc(runner)
              receiver.send(method, *call_args[0...-1], &proc)
            else
              receiver.send(method, *call_args)
            end
          end
          
        end # class RubySendCallable
      end # class Core
    end # module System
  end # module R
end # module SByC