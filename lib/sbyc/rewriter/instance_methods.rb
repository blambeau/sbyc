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
        @stack.push(node)
        rule = @rules.find{|r| r === node}
        result = (rule ? rule.apply(self, node) : nil)
        @stack.pop
        result
      end
      
      # Applies rules on each child of the context node and returns
      # an array collecting the result
      def apply_all(node = context_node)
        node.children.collect{|c| apply(c)}
      end
      
    end # module InstanceMethods
    include InstanceMethods
  end # class Rewriter
end # module SByC
