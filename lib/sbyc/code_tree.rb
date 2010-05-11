require 'sbyc/code_tree/ast_node'
require 'sbyc/code_tree/leaf_node'
require 'sbyc/code_tree/basic_parser'
require 'sbyc/code_tree/functional_parser'
require 'sbyc/code_tree/imperative_parser'
module SByC
  module CodeTree
    
    # Parses some code or block
    def parse(code = nil, &block)
      SByC::CodeTree::FunctionalParser::parse(code, &block)
    end
    module_function :parse
    
    # Parses some code or block
    def parse_imperative(code = nil, &block)
      SByC::CodeTree::ImperativeParser::parse(code, &block)
    end
    module_function :parse_imperative
    
    # Converts an argument to an parse tree (an ASTNode instance)
    def coerce(arg)
      case arg
        when ::SByC::CodeTree::AstNode
          arg
        when Proc, String
          ::SByC::CodeTree::parse(arg)
        else
          raise "Unable to coerce #{arg} to a CodeTree::AstNode"
      end
    end
    module_function :coerce
    
  end # module CodeTree
end # module SByC