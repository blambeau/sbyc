SByC::R::Heading::Operators.define{
  
  operator{|op|
    op.description = %Q{ Returns domain of an attribute }
    op.signature   = [SByC::R::Symbol, SByC::R::Heading]
    op.argnames    = [:'attr-name', :operand]
    op.returns     = SByC::R::Domain
    op.aliases     = [:'domain-of', :[]]
  }
  def domain_of(attr_name, operand) operand.domain_of(attr_name) end
  
}