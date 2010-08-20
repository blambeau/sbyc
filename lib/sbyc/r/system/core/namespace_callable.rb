module SByC
  module R
    module System
      class Core
        class NamespaceCallable
          include R::Callable
          
          def call_signature(runner, args, binding)
            @call_signature ||= [ [ ::Symbol ] ]
          end
          
          def sbyc_call(runner, args, binding)
            name, = runner.ensure_args(args[0..0], call_signature(runner, args, binding), binding){
              call_error(runner, args, binding)
            }
            if args.size == 1
              runner.with_namespace(name, true)
            else
              runner.with_namespace(name, true){
                args.each{|arg|
                  runner.evaluate(arg, binding)
                }
              }
            end
          end
          
        end # class NamespaceCallable
      end # class Core
    end # module System
  end # module R
end # module SByC