SByC::R::Float::Operators.define{

  operator {|op|
    op.description = %Q{ Addition on floats }
    op.signature   = star(system::Float)
    op.argnames    = [:operands]
    op.returns     = system::Float
    op.aliases     = [:addition, :plus, :+]
  }
  def addition(operands); operands.inject(0.0){|memo, op| memo + op}; end

  operator {|op|
    op.description = %Q{ Substraction on floats }
    op.signature   = s(system::Float, system::Float)
    op.argnames    = [:left, :right]
    op.returns     = system::Float
    op.aliases     = [:substraction, :minus, :-]
  }
  def substraction(left, right); left - right; end

  operator {|op|
    op.description = %Q{ Multiplication on floats }
    op.signature   = star(system::Float)
    op.argnames    = [:operands]
    op.returns     = system::Float
    op.aliases     = [:multiplication, :multiply, :times, :*]
  }
  def multiplication(operands); operands.inject(1.0){|memo, op| memo * op}; end
  
}