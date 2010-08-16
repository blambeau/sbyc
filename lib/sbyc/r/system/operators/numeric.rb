SByC::R::Numeric::Operators.define{

  operator {|op|
    op.description = %Q{ Addition on numerics }
    op.signature   = star(system::Numeric)
    op.argnames    = [:operands]
    op.returns     = system::Numeric
    op.aliases     = [:addition, :plus, :+]
  }
  def addition(operands); operands.inject(0.0){|memo, op| memo + op}; end

  operator {|op|
    op.description = %Q{ Substraction on numerics }
    op.signature   = seq(system::Numeric, system::Numeric)
    op.argnames    = [:left, :right]
    op.returns     = system::Numeric
    op.aliases     = [:substraction, :minus, :-]
  }
  def substraction(left, right); left - right; end

  operator {|op|
    op.description = %Q{ Multiplication on numerics }
    op.signature   = star(system::Numeric)
    op.argnames    = [:operands]
    op.returns     = system::Numeric
    op.aliases     = [:multiplication, :multiply, :times, :*]
  }
  def multiplication(operands); operands.inject(1.0){|memo, op| memo * op}; end
  
}
SByC::R::Numeric.add_immediate_structure SByC::R::TotalOrder