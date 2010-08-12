SByC::R::Numeric::Operators.define{

  operator {|op|
    op.description = %Q{ Days addition on a date }
    op.signature   = [SByC::R::Date, SByC::R::Integer]
    op.argnames    = [:operand, :nb_days]
    op.returns     = SByC::R::Date
    op.aliases     = [:add_days, :+]
  }
  def add_days(operand, nb_days); operand + nb_days; end

}
SByC::R::Date.add_immediate_structure SByC::R::TotalOrder