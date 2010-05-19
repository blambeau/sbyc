require 'sbyc/codetree/ast_node'
require 'sbyc/codetree/proc_parser'
require 'sbyc/codetree/eval'
require 'sbyc/codetree/matching'
module SByC
  module CodeTree
    
    # Parses some code or block
    def parse(code = nil, &block)
      ProcParser::parse(code, &block)
    end
    module_function :parse
    
    # Alias for _parse_
    def expr(code = nil, &block)
      ProcParser::parse(code, &block)
    end
    module_function :expr
    
    # Factors a CodeTree::Matcher instance
    def matcher(code = nil, &block)
      CodeTree::Matcher.new(parse(code, &block))
    end
    module_function :matcher
    
    # Converts an argument to an parse tree (an ASTNode instance)
    def coerce(arg)
      case arg
        when AstNode
          arg
        when Proc, String
          CodeTree::parse(arg)
        else
          raise "Unable to coerce #{arg.inspect} to a CodeTree::AstNode"
      end
    end
    module_function :coerce
    
  end # module CodeTree
end # module SByC