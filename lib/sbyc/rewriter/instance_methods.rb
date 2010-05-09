module SByC
  class Rewriter
    module InstanceMethods
      
      # Installed rules, by method name
      attr_reader :rules
      
      # Creates a Rewriter instance
      def initialize
        @rules = {}
        self.rule(:literal){|r, w| w.literal}
        yield(self) if block_given?
      end
      
      # Adds a rule
      def rule(method_name, &block)
        @rules[method_name] = block
      end
      
      # Rewrites some code
      def rewrite(code = nil, &block)
        ast = ::SByC::CodeTree.coerce(code || block)
        apply(ast)
      end
      
      # Applies rules on a node      
      def apply(node)
        case node
          when ::SByC::CodeTree::LeafNode
            if rules.key?(node.name)
              rules[node.name].call(self, node)
            end
          when ::SByC::CodeTree::AstNode
            if rules.key?(node.name)
              rules[node.name].call(self, *node.children)
            end
          else
            node
        end
      end
      
    end # module InstanceMethods
    include InstanceMethods
  end # class Rewriter
end # module SByC