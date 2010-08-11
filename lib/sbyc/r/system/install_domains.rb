SByC::R::Alpha   = SByC::R::CreateUnionDomain(:Alpha,   SByC::R::AlphaDomain)
SByC::R::Domain  = SByC::R::RefineUnionDomain(:Domain,  SByC::R::Alpha,   SByC::R::DomainDomain)
SByC::R::Boolean = SByC::R::RefineUnionDomain(:Boolean, SByC::R::Alpha,   SByC::R::BooleanDomain)
SByC::R::Numeric = SByC::R::CreateUnionDomain(:Numeric, SByC::R::NumericDomain)
SByC::R::Integer = SByC::R::RefineUnionDomain(:Integer, SByC::R::Numeric, SByC::R::IntegerDomain)
SByC::R::Float   = SByC::R::RefineUnionDomain(:Float,   SByC::R::Numeric, SByC::R::FloatDomain)
SByC::R::String  = SByC::R::RefineUnionDomain(:String,  SByC::R::Alpha,   SByC::R::StringDomain)
SByC::R::Time    = SByC::R::RefineUnionDomain(:Time,    SByC::R::Alpha,   SByC::R::TimeDomain)
SByC::R::Date    = SByC::R::RefineUnionDomain(:Date,    SByC::R::Alpha,   SByC::R::DateDomain)
SByC::R::Symbol  = SByC::R::RefineUnionDomain(:Symbol,  SByC::R::Alpha,   SByC::R::SymbolDomain)
SByC::R::Regexp  = SByC::R::RefineUnionDomain(:Regexp,  SByC::R::Alpha,   SByC::R::RegexpDomain)
SByC::R::Module  = SByC::R::RefineUnionDomain(:Module,  SByC::R::Alpha,   SByC::R::ModuleDomain)



