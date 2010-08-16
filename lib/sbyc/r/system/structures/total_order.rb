SByC::R::TotalOrder = SByC::R::Operator::Set.factor(SByC::R){

  operator {|op|
    op.description = %Q{ Compares two values }
    op.signature   = [_, _]
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:compare, :'<=>']
  }
  def compare(left, right); (left <=> right); end
  
  operator {|op|
    op.description = %Q{ Greater-than }
    op.signature   = [_, _]
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:gt, :'>']
  }
  def gt(left, right); (left > right); end
  
  operator {|op|
    op.description = %Q{ Greater-than-or-equal-to }
    op.signature   = [_, _]
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:gte, :'>=']
  }
  def gte(left, right); (left >= right); end
  
  operator {|op|
    op.description = %Q{ Less-than }
    op.signature   = [_, _]
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:lt, :'<']
  }
  def lt(left, right); (left < right); end
  
  operator {|op|
    op.description = %Q{ Less-than-or-equal-to }
    op.signature   = [_, _]
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:lte, :'<=']
  }
  def lte(left, right); (left <= right); end
  
}