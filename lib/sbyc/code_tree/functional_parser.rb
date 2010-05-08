module SByC
  module CodeTree
    class FunctionalParser < BasicParser
      
      # When something is missing
      def method_missing(name, *args, &block)
        ::SByC::CodeTree::AstNode::coerce([name, args, block])
      end
            
      # Parses a block
      def self.parse(code = nil, &block)
        block = code || block
        case block
          when Proc
            self.new.instance_eval(&block)
          when String
            self.new.instance_eval(block)
          else
            raise ArgumentError, "Unable to parse #{block} : #{block.class}"
        end
      end
      
    end # class FunctionalParser
  end # module CodeTree
end # module SByC