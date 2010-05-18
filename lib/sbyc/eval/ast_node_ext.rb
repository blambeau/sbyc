module SByC
  module CodeTree
    class AstNode
      
      # Generates the code of an object evaluation
      def object_compile(scope_object = "scope", scope_method = :[])
        ::SByC::Eval::ObjectEval.object_compile(self, scope_object, scope_method)
      end
      
      # Executes object evaluation of this ast
      def object_eval(scope = {})
        ::SByC::Eval::ObjectEval.object_eval(self, scope)
      end
      alias :call :object_eval
      alias :eval :object_eval
      
      # Executes functional evaluation of this ast
      def functional_eval(master_object, scope = {}) 
        ::SByC::Eval::FunctionalEval.functional_eval(self, master_object, scope)
      end
      alias :apply :functional_eval
      
    end # class AstNode
  end # module CodeTree
end # module SByC