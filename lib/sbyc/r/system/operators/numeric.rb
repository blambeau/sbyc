SByC::R.operators.define{

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
  
  ###
  operator {|op|
    op.description = %Q{ Compares two values }
    op.signature   = s(system::Numeric, system::Numeric)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:compare, :'<=>']
  }
  def compare(left, right); (left <=> right); end
  
  operator {|op|
    op.description = %Q{ Greater-than }
    op.signature   = s(system::Numeric, system::Numeric)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:gt, :'>']
  }
  def gt(left, right); (left > right); end
  
  operator {|op|
    op.description = %Q{ Greater-than-or-equal-to }
    op.signature   = s(system::Numeric, system::Numeric)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:gte, :'>=']
  }
  def gte(left, right); (left >= right); end
  
  operator {|op|
    op.description = %Q{ Less-than }
    op.signature   = s(system::Numeric, system::Numeric)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:lt, :'<']
  }
  def lt(left, right); (left < right); end
  
  operator {|op|
    op.description = %Q{ Less-than-or-equal-to }
    op.signature   = s(system::Numeric, system::Numeric)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:lte, :'<=']
  }
  def lte(left, right); (left <= right); end
   
}