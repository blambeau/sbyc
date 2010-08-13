SByC::R::Domain::Operators.define{

  operator{|op|
    op.description = %Q{ Returns name of a domain }
    op.signature   = [SByC::R::Domain]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:'name-of']
  }
  def name_of(operand) operand.domain_name; end
  
}