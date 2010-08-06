module SByC
  module CodeTree
    class AstNode
    
      # Generates the code of an object evaluation
      def type_check_by_heading(args, type_system = nil)
        type_system ||= SByC::Typing::R
        type_system.result_domain_by_heading(args, self)
      end
    
      # Generates the code of an object evaluation
      def type_check_by_args(args, type_system = nil)
        type_system ||= SByC::Typing::R
        type_system.result_domain_by_args(args, self)
      end
      alias :type_check :type_check_by_args
        
    end # class AstNode
  end # module CodeTree
end # module SByC