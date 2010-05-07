module SByC
  module CodeTree
    class Parser
      
      def method_missing(name, *args, &block)
        ::SByC::CodeTree::AstNode::coerce([name, args, block])
      end
      
      # Parses a block
      def self.parse(code = nil, &block)
        block = code || block
        Parser.new.instance_eval(&block)
      end
      
    end # class Parser
  end # module CodeTree
end # module SByC