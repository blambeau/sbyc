SByC::R::operators.define{
 
  operator{|op|
    op.description = %Q{ Generates a new type trough a generator }
    op.signature   = s(system::Domain, system::Domain)
    op.argnames    = [:domain, :subdomain]
    op.returns     = system::Domain
    op.aliases     = [:'generate-domain']
  }
  def generate_domain(domain, subdomain)
    name = :"#{domain.domain_name}<#{subdomain.domain_name}>"
    domain.domain_generator.generate(name, subdomain)
  rescue Exception => ex
    raise SByC::TypeError, "Unable to generate domain #{name}\n#{ex.message}"
  end
  
  operator{|op|
    op.description = %Q{ Factors a scalar type }
    op.signature   = s(system::Symbol) + plus(system::Symbol, system::Domain)
    op.argnames    = [:'domain-name', :heading]
    op.returns     = system::Domain
    op.aliases     = [:'scalar-domain']
  }
  def scalar_domain(name, heading)
    system.builder.Scalar(name, system::Heading.new(::Hash[*heading.flatten]))
  end
 
  operator{|op|
    op.description = %Q{ Returns date of today }
    op.signature   = []
    op.argnames    = []
    op.returns     = system::Date
    op.aliases     = [:today]
  }
  def today() ::Date.today; end
 
  operator{|op|
    op.description = %Q{ Returns time of now }
    op.signature   = []
    op.argnames    = []
    op.returns     = system::Time
    op.aliases     = [:now]
  }
  def now() ::Time.now; end
  
}