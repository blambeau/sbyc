require 'sbyc/codetree'
module SByC

  # Version
  VERSION = "0.0.1".freeze
  
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

  # Parses some code and returns a code tree.
  def parse(code = nil, &block)
    ::SByC::CodeTree::parse(code, &block)
  end
  module_function :parse
  
  # Alias for parse
  def expr(code = nil, &block)
    ::SByC::CodeTree::parse(code, &block)
  end
  module_function :expr
  
  # Factors an Matching::Matcher instance
  def matcher(code = nil, &block)
    ::SByC::CodeTree::Matcher::new(parse(code, &block))
  end
  module_function :matcher
  
end
