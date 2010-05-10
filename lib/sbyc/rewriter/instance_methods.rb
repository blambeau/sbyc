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
        self.rule(:literal){|r, w| w.literal}
        yield(self) if block_given?
      end
      
      # Adds a rule
      def rule(method_name, &block)
        @rules << ::SByC::Rewriter::Match.new(method_name, block)
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
      
    end # module InstanceMethods
    include InstanceMethods
  end # class Rewriter
end # module SByC