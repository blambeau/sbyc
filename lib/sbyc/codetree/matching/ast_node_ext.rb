module SByC
  module CodeTree
    class AstNode
    
      # Applies ast node matching
      def ===(other)
        if other.kind_of?(CodeTree::AstNode)
          CodeTree::Matcher.new(self) === other
        else
          super
        end
      end
    
    end # class AstNode
  end # module CodeTree
end # module SByC