SByC::R.operators.define{

  operator{|op|
    op.description = %Q{ Returns name of a domain }
    op.signature   = s(system::Domain)
    op.argnames    = [:operand]
    op.returns     = system::String
    op.aliases     = [:'name-of']
  }
  def name_of(operand) operand.domain_name; end

  operator{|op|
    op.description = %Q{ Checks if a domain is a subdomain of another one }
    op.signature   = s(system::Domain, system::Domain)
    op.argnames    = [:'sub-domain', :domain]
    op.returns     = system::Boolean
    op.aliases     = [:'is-sub-domain-of?']
  }
  def is_sub_domain_of?(subdomain, domain)
    subdomain.is_sub_domain_of?(domain)
  end
  
  operator{|op|
    op.description = %Q{ Checks if a domain is a proper subdomain of another one }
    op.signature   = s(system::Domain, system::Domain)
    op.argnames    = [:'sub-domain', :domain]
    op.returns     = system::Boolean
    op.aliases     = [:'is-proper-sub-domain-of?']
  }
  def is_proper_sub_domain_of?(subdomain, domain)
    subdomain.is_proper_sub_domain_of?(domain)
  end
  
  operator{|op|
    op.description = %Q{ Checks if a domain is a super domain of another one }
    op.signature   = s(system::Domain, system::Domain)
    op.argnames    = [:'super-domain', :domain]
    op.returns     = system::Boolean
    op.aliases     = [:'is-super-domain-of?']
  }
  def is_super_domain_of?(superdomain, domain)
    is_sub_domain_of?(domain, superdomain)
  end
  
  operator{|op|
    op.description = %Q{ Checks if a domain is a proper super domain of another one }
    op.signature   = s(system::Domain, system::Domain)
    op.argnames    = [:'super-domain', :domain]
    op.returns     = system::Boolean
    op.aliases     = [:'is-proper-super-domain-of?']
  }
  def is_proper_super_domain_of?(superdomain, domain)
    is_proper_sub_domain_of?(domain, superdomain)
  end
  
}