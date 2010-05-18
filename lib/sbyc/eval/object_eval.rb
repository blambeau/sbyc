module SByC
  module Eval
    module ObjectEval
      
      # Evaluates this AST with an object style.
      def object_eval(ast, scope = {}) 
        ast.visit{|node, collected|
          case func = node.function
            when :'_'
              collected.first
            when :'?'
              scope[*collected]
            else
              collected[0].send(func, *collected[1..-1])
          end
        }
      end
      module_function :object_eval
    
    end # module ObjectEval
  end # module Eval
end # module SByC