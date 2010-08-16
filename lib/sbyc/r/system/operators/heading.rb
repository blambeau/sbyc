SByC::R::Heading::Operators.define{
  
  operator{|op|
    op.description = %Q{ Returns domain of an attribute }
    op.signature   = s(system::Symbol, system::Heading)
    op.argnames    = [:'attr-name', :operand]
    op.returns     = system::Domain
    op.aliases     = [:'domain-of', :[]]
  }
  def domain_of(attr_name, operand) operand.domain_of(attr_name) end
  
}