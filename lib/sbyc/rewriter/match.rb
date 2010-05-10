module SByC
  class Rewriter
    class Match
      
      # Matches any node
      ANY = lambda{|ast_node| true}
    
      # Matches a branch node
      BRANCH = lambda{|ast_node| ast_node.kind_of?(::SByC::CodeTree::AstNode) and ast_node.branch?}
    
      # Matches a leaf node
      LEAF = lambda{|ast_node| ast_node.kind_of?(::SByC::CodeTree::AstNode) and ast_node.leaf?}
    
      # Coerce argument to a Match instance
      def self.coerce(arg, block)
        case arg
          when Proc
            Match.new(arg, block)
          when Symbol
            Match.new(lambda{|node| node.kind_of?(::SByC::CodeTree::AstNode) and node.name == arg}, block)
          when "."
            Match.new(SByC::Rewriter::Match::ANY, block)
          when "*"
            Match.new(SByC::Rewriter::Match::BRANCH, block)
          when "@*"
            Match.new(SByC::Rewriter::Match::LEAF, block)
        end
      end
      
      # Creates a match instance
      def initialize(predicate, block)
        @predicate, @block = predicate, block
      end
      
      # Does this match 
      def matches?(ast_node)
        @predicate.call(ast_node)
      end
      alias :=== :matches?
      
      # Applies this match
      def apply(rewriter, ast_node)
        case ast_node
          when ::SByC::CodeTree::LeafNode
            @block.call(rewriter, ast_node)
          when ::SByC::CodeTree::AstNode
            @block.call(rewriter, *ast_node.children)
          else
            ast_node
        end
      end
      
    end # class Match
  end # class Rewriter
end # module SByC