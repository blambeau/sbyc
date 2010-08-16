SByC::R::Expression::Operators.define{
  
  operator{|op|
    op.description = %Q{ Evaluates the expression }
    op.signature   = s(system::Expression)
    op.argnames    = [:operand]
    op.returns     = system::Alpha
    op.aliases     = [:evaluate]
  }
  def evaluate(operand) operand.evaluate({}); end

}