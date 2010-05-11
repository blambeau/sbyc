require 'sbyc/code_tree/ast_node'
require 'sbyc/code_tree/leaf_node'
require 'sbyc/code_tree/basic_object'
require 'sbyc/code_tree/imperative_parser'
module SByC
  module CodeTree
    
    # Parses some code or block
    def parse(code = nil, &block)
      SByC::CodeTree::ImperativeParser::parse(code, &block)
    end
    module_function :parse
    
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