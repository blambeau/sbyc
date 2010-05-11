module SByC
  class Rewriter
    module InstanceMethods
      
      # Installed rules, by method name
      attr_reader :rules
      
      # The scope
      attr_reader :scope
      
      # Creates a Rewriter instance
      def initialize
        @rules = []
        yield(self) if block_given?
      end
      
      # Adds a rule
      def rule(match, &block)
        @rules << ::SByC::Rewriter::Match.coerce(match, block)
      end
      
      # Rewrites some code
      def rewrite(code = nil, scope = nil, &block)
        @scope = block ? code : scope
        apply(::SByC::CodeTree.coerce(block || code))
      ensure 
        @scope = nil
      end
      
      # Applies rules on a node      
      def apply(node)
        rule = @rules.find{|r| r === node}
        rule ? rule.apply(self, node) : nil
      end
      
      # Applies rules on each child of the context node and returns
      # an array collecting the result
      def apply_all(node)
        node.children.collect{|c| apply(c)}
      end
      
    end # module InstanceMethods
    include InstanceMethods
  end # class Rewriter
end # module SByC
