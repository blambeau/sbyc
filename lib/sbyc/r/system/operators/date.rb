SByC::R.operators.define{

  operator {|op|
    op.description = %Q{ Days addition on a date }
    op.signature   = s(system::Date, system::Integer)
    op.argnames    = [:operand, :nb_days]
    op.returns     = system::Date
    op.aliases     = [:'days+', :+]
  }
  def add_days(operand, nb_days); operand + nb_days; end

  ###
  operator {|op|
    op.description = %Q{ Compares two values }
    op.signature   = s(system::Date, system::Date)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:compare, :'<=>']
  }
  def compare(left, right); (left <=> right); end
  
  operator {|op|
    op.description = %Q{ Greater-than }
    op.signature   = s(system::Date, system::Date)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:gt, :'>']
  }
  def gt(left, right); (left > right); end
  
  operator {|op|
    op.description = %Q{ Greater-than-or-equal-to }
    op.signature   = s(system::Date, system::Date)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:gte, :'>=']
  }
  def gte(left, right); (left >= right); end
  
  operator {|op|
    op.description = %Q{ Less-than }
    op.signature   = s(system::Date, system::Date)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:lt, :'<']
  }
  def lt(left, right); (left < right); end
  
  operator {|op|
    op.description = %Q{ Less-than-or-equal-to }
    op.signature   = s(system::Date, system::Date)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:lte, :'<=']
  }
  def lte(left, right); (left <= right); end
}
