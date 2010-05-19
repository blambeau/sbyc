require 'sbyc/code_tree/ast_node'
require 'sbyc/code_tree/proc_parser'
require 'sbyc/code_tree/eval'
module SByC
  module CodeTree
    
    # Parses some code or block
    def parse(code = nil, &block)
      SByC::CodeTree::ProcParser::parse(code, &block)
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
          raise "Unable to coerce #{arg.inspect} to a CodeTree::AstNode"
      end
    end
    module_function :coerce
    
  end # module CodeTree
end # module SByC