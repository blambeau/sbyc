module SByC
  module R
    module System
      class Core
        class PutsCallable
          include R::Callable
          
          def call_signature(runner, args, binding)
            @call_signature ||= [ [ ] ]
          end
          
          def coerce(runner, args, binding)
            puts runner.fed(:Alpha).domain_of(args.first).to_literal(args.first)
          end
          
        end # class PutsCallable
      end # class Core
    end # module System
  end # module R
end # module SByC