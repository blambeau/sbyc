SByC::R::GlobalOperators.define{
 
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