SByC::R.operators.define{

  operator {|op|
    op.description = %Q{ Computes boolean complement }
    op.signature   = s(system::Boolean)
    op.argnames    = [:operand]
    op.returns     = system::Boolean
    op.aliases     = [:complement, :'!', :'~', :not]
  }
  def complement(operand); !operand end
  
  operator {|op|
    op.description = %Q{ Computes boolean conjunction }
    op.signature   = s(system::Boolean, system::Boolean)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:conjunction, :'&', :and]
  }
  def conjunction(left, right) (left & right) end
  
  operator {|op|
    op.description = %Q{ Computes boolean disjunction }
    op.signature   = s(system::Boolean, system::Boolean)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:disjunction, :'|', :or]
  }
  def disjunction(left, right) (left | right) end
  
}