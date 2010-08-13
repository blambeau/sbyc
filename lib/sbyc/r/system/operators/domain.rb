SByC::R::Domain::Operators.define{

  operator{|op|
    op.description = %Q{ Returns name of a domain }
    op.signature   = [SByC::R::Domain]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:'name-of']
  }
  def name_of(operand) operand.domain_name; end

  operator{|op|
    op.description = %Q{ Checks if a value belongs to a domain }
    op.signature   = [SByC::R::Domain, SByC::R::Alpha]
    op.argnames    = [:domain, :operand]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:'is-a?']
  }
  def is_a?(domain, operand) domain.is_value?(operand); end
  
  
}