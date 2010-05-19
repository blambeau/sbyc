module CodeTree
  
  # Operator names
  OPERATOR_NAMES = {
    :[]  => :get,
    :[]= => :set,
    :**  => :exponentiation,
    :~   => :complement,
    :==  => :eq,
    #:!=  => :neq,
    :-@  => :unary_minus,
    :+@  => :unary_plus,
    :-   => :minus,
    :+   => :plus,
    :*   => :times,
    :/   => :divide,
    :%   => :modulo,
    :=~  => :match,
    :=== => :matches?,
    :&   => :bool_and,
    :|   => :bool_or,
    :>   => :gt,
    :>=  => :gte,
    :<=  => :lte,
    :<   => :lt,
    :>>  => :right_shift,
    :<<  => :left_shift,
    :'^' => :exclusive,
    :<=> => :compare
  }
  REVERSE_OPERATOR_NAMES = Hash[*OPERATOR_NAMES.to_a.collect{|c| c.reverse}.flatten]
  
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
  
  # Factors a rewriter instance
  def rewriter(&definition)
    CodeTree::Rewriting::Rewriter.new(&definition)
  end
  module_function :rewriter
  
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
require 'sbyc/codetree/ast_node'
require 'sbyc/codetree/proc_parser'
require 'sbyc/codetree/eval'
require 'sbyc/codetree/matching'
require 'sbyc/codetree/rewriting'
