module SByC
  module R
    module Callable
      module AstBased
        include Callable
        
        # The asbtract syntax tree
        attr_reader :ast
      
        def compute_ast_arity
          vars = {}
          ast.visit{|node, collected|
            if node.function == :'?' && 
               looks_an_unbounded_variable?(node.literal)
              vars[node.literal] = true
            end
          }
          vars.size
        end
        
        # Checks if a variable looks an unbounded variable
        def looks_an_unbounded_variable?(name)
          name.to_s =~ /^\$(\d+)$/
        end

        def arity
          @arity ||= compute_ast_arity
        end
      
        def call_signature(runner, args, binding)
          @call_signature ||= Array.new(arity).fill{|index| []}
        end
        
      end # module AstBased
    end # module Callable
  end # module R
end # module SByC