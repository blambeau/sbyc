module SByC
  module Eval
    module ObjectEval
      
      # Generates code for an object evaluation
      def object_compile(ast, scope_object = "scope", scope_method = :[])
        ast.visit{|node, collected|
          case func = node.function
            when :'_'
              collected.first.inspect
            when :'?'
              if scope_method == :[]
                "#{scope_object}[#{collected.join(', ')}]"
              else
                "#{scope_object}.#{scope_method}(#{collected.join(', ')})"
              end
            else
              "#{collected[0]}.#{func}(#{collected[1..-1].join(', ')})"
          end
        }
      end
      module_function :object_compile
      
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