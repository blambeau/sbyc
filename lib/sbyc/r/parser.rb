module SByC
  module R
    class Parser < SByC::CodeTree::Parsing::TextParser

      # Resolves a given domain
      def resolve_domain(str)
        CodeTree::AstNode.new(:fed, [literal_node(str.to_sym)])
      end
      
    end # class Parser
  end # module R 
end # module SByC