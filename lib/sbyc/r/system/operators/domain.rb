SByC::R::Domain::Operators.define{

  operator{|op|
    op.description = %Q{ Checks if a value belongs to a domain }
    op.signature   = [SByC::R::Domain, SByC::R::Alpha]
    op.argnames    = [:domain, :operand]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:'is-a?']
  }
  def is_a?(domain, operand) domain.is_value?(operand); end
  
  operator{|op|
    op.description = %Q{ Returns name of a domain }
    op.signature   = [SByC::R::Domain]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:'name-of']
  }
  def name_of(operand) operand.domain_name; end

  operator{|op|
    op.description = %Q{ Checks if a domain is a subdomain of another one }
    op.signature   = [SByC::R::Domain, SByC::R::Domain]
    op.argnames    = [:'sub-domain', :domain]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:'is-sub-domain-of?']
  }
  def is_sub_domain_of?(subdomain, domain)
    subdomain.is_sub_domain_of?(domain)
  end
  
  operator{|op|
    op.description = %Q{ Checks if a domain is a proper subdomain of another one }
    op.signature   = [SByC::R::Domain, SByC::R::Domain]
    op.argnames    = [:'sub-domain', :domain]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:'is-proper-sub-domain-of?']
  }
  def is_proper_sub_domain_of?(subdomain, domain)
    subdomain.is_proper_sub_domain_of?(domain)
  end
  
  operator{|op|
    op.description = %Q{ Checks if a domain is a super domain of another one }
    op.signature   = [SByC::R::Domain, SByC::R::Domain]
    op.argnames    = [:'super-domain', :domain]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:'is-super-domain-of?']
  }
  def is_super_domain_of?(superdomain, domain)
    is_sub_domain_of?(domain, superdomain)
  end
  
  operator{|op|
    op.description = %Q{ Checks if a domain is a proper super domain of another one }
    op.signature   = [SByC::R::Domain, SByC::R::Domain]
    op.argnames    = [:'super-domain', :domain]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:'is-proper-super-domain-of?']
  }
  def is_proper_super_domain_of?(superdomain, domain)
    is_proper_sub_domain_of?(domain, superdomain)
  end
  
}