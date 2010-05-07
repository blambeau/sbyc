require 'sbyc/code_tree/ast_node'
require 'sbyc/code_tree/leaf_node'
require 'sbyc/code_tree/parser'
module SByC
  module CodeTree
    
    # Parses some code or block
    def parse(code = nil, &block)
      SByC::CodeTree::Parser::parse(code, &block)
    end
    module_function :parse
    
    # Converts an argument to an parse tree (an ASTNode instance)
    def coerce(arg)
      case arg
        when ::SByC::CodeTree::AstNode
          arg
        when Proc, String
          ::SByC::CodeTree::parse(arg)
      end
    end
    module_function :coerce
    
  end # module CodeTree
end # module SByC