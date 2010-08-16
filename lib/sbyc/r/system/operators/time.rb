SByC::R.operators.define{
  
  ###
  operator {|op|
    op.description = %Q{ Compares two values }
    op.signature   = s(system::Time, system::Time)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:compare, :'<=>']
  }
  def compare(left, right); (left <=> right); end
  
  operator {|op|
    op.description = %Q{ Greater-than }
    op.signature   = s(system::Time, system::Time)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:gt, :'>']
  }
  def gt(left, right); (left > right); end
  
  operator {|op|
    op.description = %Q{ Greater-than-or-equal-to }
    op.signature   = s(system::Time, system::Time)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:gte, :'>=']
  }
  def gte(left, right); (left >= right); end
  
  operator {|op|
    op.description = %Q{ Less-than }
    op.signature   = s(system::Time, system::Time)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:lt, :'<']
  }
  def lt(left, right); (left < right); end
  
  operator {|op|
    op.description = %Q{ Less-than-or-equal-to }
    op.signature   = s(system::Time, system::Time)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:lte, :'<=']
  }
  def lte(left, right); (left <= right); end

}