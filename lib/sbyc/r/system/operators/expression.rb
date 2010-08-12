SByC::R::Expression::Operators.define{
  
  operator{|op|
    op.description = %Q{ Evaluates the expression }
    op.signature   = [SByC::R::Expression]
    op.argnames    = [:operand]
    op.returns     = SByC::R::Alpha
    op.aliases     = [:evaluate]
  }
  def evaluate(operand) operand.evaluate({}); end

}