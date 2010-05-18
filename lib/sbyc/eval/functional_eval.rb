module SByC
  module Eval
    module FunctionalEval
      
      # Evaluates this AST with an object style.
      def functional_eval(ast, master_object, scope = {}) 
        ast.visit{|node, collected|
          case func = node.function
            when :_
              collected.first
            when :'?'
              scope[*collected]
            else
              master_object.send(func, *collected)
          end
        }
      end
      module_function :functional_eval
    
    end # module FunctionalEval
  end # module Eval
end # module SByC