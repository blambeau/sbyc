require 'sbyc/core_ext'
require 'sbyc/code_tree'
require 'sbyc/expr'
require 'sbyc/system'
require 'sbyc/matching'
require 'sbyc/rewriter'
module SByC
  class TypeCheckingError < StandardError; end

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
  
  # Factors an Expr instance
  def expr(code = nil, &block)
    ::SByC::Expr::coerce(code, &block)
  end
  module_function :expr
  
  # Applies type checking to a code
  def type_check(code = nil, system = ::SByC::RubySystem, &block)
    system.type_check(code, &block)
  end
  module_function :type_check
  
  # Parses some code and returns a code tree.
  def to_ruby_code(code = nil, system = ::SByC::RubySystem, &block)
    system.to_ruby_code(code, &block)
  end
  module_function :to_ruby_code
  
  # Parses some code and returns a code tree.
  def compile(code = nil, system = ::SByC::RubySystem, &block)
    system.compile(code, &block)
  end
  module_function :compile
  
  # Parses some code and returns a code tree.
  def execute(code = nil, system = ::SByC::RubySystem, &block)
    compile(system, code, &block).call
  end
  module_function :execute
  
end

# Alias for ::SByC::expr(code, &block)
def SByC(code = nil, &block)
  ::SByC::expr(code, &block)
end

require 'sbyc/system/ruby_system'
