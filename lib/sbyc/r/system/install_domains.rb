SByC::R::Alpha      = SByC::R::AlphaDomain.factor
SByC::R::Domain     = SByC::R::Alpha.refine(:Domain,     SByC::R::DomainDomain)

SByC::R::Boolean = SByC::R::Alpha.refine(:Boolean, SByC::R::BooleanDomain)

SByC::R::Numeric = SByC::R::Alpha.refine(:Numeric, SByC::R::AbstractDomain::Union, SByC::R::NumericDomain)
  SByC::R::Integer = SByC::R::Numeric.refine(:Integer, SByC::R::IntegerDomain)
  SByC::R::Float   = SByC::R::Numeric.refine(:Float,   SByC::R::FloatDomain)

SByC::R::String  = SByC::R::Alpha.refine(:String, SByC::R::StringDomain)
SByC::R::Time    = SByC::R::Alpha.refine(:Time,   SByC::R::TimeDomain)
SByC::R::Date    = SByC::R::Alpha.refine(:Date,   SByC::R::DateDomain)
SByC::R::Symbol  = SByC::R::Alpha.refine(:Symbol, SByC::R::SymbolDomain)
SByC::R::Regexp  = SByC::R::Alpha.refine(:Regexp, SByC::R::RegexpDomain)
SByC::R::Module  = SByC::R::Alpha.refine(:Module, SByC::R::ModuleDomain)

SByC::R::Expression = SByC::R::Alpha.refine(:Expression, SByC::R::ExpressionDomain)


