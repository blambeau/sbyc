module SByC
  module CodeTree
    class AstNode
      
      # Generates the code of an object evaluation
      def object_compile(scope_object = "scope", scope_method = :[])
        ::SByC::Eval::ObjectEval.object_compile(self, scope_object, scope_method)
      end
      
      # Generates a lambda function for object evaluation
      def object_proc(scope_method = :[])
        ::SByC::Eval::ObjectEval.object_proc(self, scope_method)
      end
      
      # Executes object evaluation of this ast
      def object_eval(scope = {}, scope_method = :[])
        ::SByC::Eval::ObjectEval.object_eval(self, scope)
      end
      alias :call :object_eval
      alias :eval :object_eval
      
      # Generates the code of an functional evaluation
      def functional_compile(receiver_object = "receiver", scope_object = "scope", scope_method = :[])
        ::SByC::Eval::FunctionalEval.functional_compile(self, receiver_object, scope_object, scope_method)
      end
      
      # Generates a lambda function for functional evaluation
      def functional_proc(scope_method = :[])
        ::SByC::Eval::FunctionalEval.functional_proc(self, scope_method)
      end
      
      # Executes functional evaluation of this ast
      def functional_eval(master_object, scope = {}, scope_method = :[]) 
        ::SByC::Eval::FunctionalEval.functional_eval(self, master_object, scope)
      end
      alias :apply :functional_eval
      
    end # class AstNode
  end # module CodeTree
end # module SByC