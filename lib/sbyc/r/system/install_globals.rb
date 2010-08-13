SByC::R::GlobalOperators.define{
 
  operator{|op|
    op.description = %Q{ Generates a new type trough a generator }
    op.signature   = [SByC::R::Domain, SByC::R::Domain]
    op.argnames    = [:domain, :subdomain]
    op.returns     = SByC::R::Domain
    op.aliases     = [:'generate-domain']
  }
  def generate_domain(domain, subdomain)
    name = :"#{domain.domain_name}<#{subdomain.domain_name}>"
    domain.domain_generator.generate(name, subdomain)
  rescue Exception => ex
    raise SByC::TypeError, "Unable to generate domain #{name}\n#{ex.message}"
  end
 
  operator{|op|
    op.description = %Q{ Returns date of today }
    op.signature   = []
    op.argnames    = []
    op.returns     = SByC::R::Date
    op.aliases     = [:today]
  }
  def today() Date.today; end
 
  operator{|op|
    op.description = %Q{ Returns time of now }
    op.signature   = []
    op.argnames    = []
    op.returns     = SByC::R::Time
    op.aliases     = [:now]
  }
  def now() Time.now; end
  
}