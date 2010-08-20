module SByC
  module R
    module System
      class Core
        class ParseCallable
          include R::Callable::SignatureBased
          
          def works_on_ast?
            true
          end
      
          def call_signature(runner, args, binding)
            @call_signature ||= [ [ CodeTree::AstNode ] ]
          end
          
          def coerce(runner, args, binding)
            args.first
          end
          
        end # class ParseCallable
      end # class Core
    end # module System
  end # module R
end # module SByC