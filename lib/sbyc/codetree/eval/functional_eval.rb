module CodeTree
  module FunctionalEval
    
    # Generates code for a functional evaluation
    def functional_compile(ast, receiver_object = "receiver", scope_object = "scope", scope_method = :[])
      ast.produce{|node, collected|
        case func = node.function
          when :_
            collected.first.inspect
          when :'?'
            if scope_method == :[]
              "#{scope_object}[#{collected.join(', ')}]"
            else
              "#{scope_object}.#{scope_method}(#{collected.join(', ')})"
            end
          else
            "#{receiver_object}.#{func}(#{collected.join(', ')})"
        end
      }
    end
    module_function :functional_compile
    
    # Generates a lambda function for functional evaluation
    def functional_proc(ast, scope_method = :[])
      ::Kernel.eval("::Kernel.lambda{|receiver, scope| #{functional_compile(ast, 'receiver', 'scope', scope_method)}}")
    end
    module_function :functional_proc
    
    # Evaluates this AST with an object style.
    def functional_eval(ast, receiver, scope = {}, scope_method = :[]) 
      functional_proc(ast, scope_method).call(receiver, scope)
    end
    module_function :functional_eval
  
  end # module FunctionalEval
end # module CodeTree