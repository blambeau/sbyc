module SByC
  class Rewriter
    module InstanceMethods
      
      # Installed rules
      attr_reader :rules
      
      # The scope
      attr_reader :scope
      
      # Creates a Rewriter instance
      def initialize
        @rules = []
        yield(self) if block_given?
      end
      
      def ANY()    ::SByC::Rewriter::Match::ANY;    end
      def BRANCH() ::SByC::Rewriter::Match::BRANCH; end
      def LEAF()   ::SByC::Rewriter::Match::LEAF;   end

      # Adds a rule to the engine
      def rule(match, &block)
        @rules << ::SByC::Rewriter::Match.coerce(match, block)
      end
      
      # Rewrites some code
      def rewrite(code = nil, scope = nil, &block)
        @stack = []
        @scope = block ? code : scope
        apply(::SByC::CodeTree.coerce(block || code))
      ensure 
        @stack = nil
        @scope = nil
      end
      
      # Returns the current context node, being the top node on the stack
      def context_node 
        @stack.last
      end
      
      # Applies rules on a node      
      def apply(node)
        if node.kind_of?(::SByC::CodeTree::AstNode)
          @stack.push(node)
          rule = @rules.find{|r| r === node}
          result = (rule ? rule.apply(self, node) : nil)
          @stack.pop
          result
        else
          node
        end
      end
      
      # Applies rules on each child of the context node and returns
      # an array collecting the result
      def apply_all(nodes = context_node.children)
        nodes.collect{|c| apply(c)}
      end
      
      # Produce a node with a specific function and arguments
      def create_node(func = context_node.function, args = apply_all)
        ::SByC::CodeTree::AstNode.coerce([func, args])
      end
      
      # Produces a node by copying another one
      def copy(node = context_node)
        create_node(node.function, apply_all(node.children))
      end
      
    end # module InstanceMethods
    include InstanceMethods
  end # class Rewriter
end # module SByC
