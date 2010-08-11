SByC::R::Boolean::Operators.define{

  operator {|op|
    op.description = %Q{ Computes boolean complement }
    op.signature   = [SByC::R::Boolean]
    op.argnames    = [:operand]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:complement, :'!', :'~', :not]
  }
  def complement(operand); !operand end
  
  operator {|op|
    op.description = %Q{ Computes boolean conjunction }
    op.signature   = [SByC::R::Boolean, SByC::R::Boolean]
    op.argnames    = [:left, :right]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:conjunction, :'&', :and]
  }
  def conjunction(left, right) (left & right) end
  
  operator {|op|
    op.description = %Q{ Computes boolean disjunction }
    op.signature   = [SByC::R::Boolean, SByC::R::Boolean]
    op.argnames    = [:left, :right]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:disjunction, :'|', :or]
  }
  def disjunction(left, right) (left | right) end
  
}