module SByC
  module R
    class Parser < SByC::CodeTree::Parsing::TextParser

      # Resolves a given domain
      def resolve_domain(str)
        literal_node(R::Domain.parse_literal(str))
      end
      
    end # class Parser
  end # module R 
end # module SByC