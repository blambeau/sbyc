SByC::R.operators.define{

  operator {|op|
    op.description = %Q{ Addition on integers }
    op.signature   = star(system::Integer)
    op.argnames    = [:operands]
    op.returns     = system::Integer
    op.aliases     = [:addition, :plus, :+]
  }
  def addition(operands); operands.inject(0){|memo, op| memo + op}; end

  operator {|op|
    op.description = %Q{ Substraction on integers }
    op.signature   = s(system::Integer, system::Integer)
    op.argnames    = [:left, :right]
    op.returns     = system::Integer
    op.aliases     = [:substraction, :minus, :-]
  }
  def substraction(left, right); left - right; end

  operator {|op|
    op.description = %Q{ Multiplication on integers }
    op.signature   = SByC::R::Operator::Signature::star(system::Integer)
    op.argnames    = [:operands]
    op.returns     = system::Integer
    op.aliases     = [:multiplication, :multiply, :times, :*]
  }
  def multiplication(operands); operands.inject(1){|memo, op| memo * op}; end
  
}