SByC::R::Builtin = SByC::R::DomainGenerator::Builtin.new
    
SByC::R::Builtin[:Alpha, [SByC::R::DomainGenerator::Tools::UnionDomain, SByC::R::AlphaDomain]]
SByC::R::Alpha.refine(:Domain, SByC::R::DomainDomain)

SByC::R::Alpha.refine(:Boolean, SByC::R::BooleanDomain)

SByC::R::Alpha.refine(:Numeric, SByC::R::DomainGenerator::Tools::UnionDomain, SByC::R::NumericDomain)
  SByC::R::Numeric.refine(:Integer, SByC::R::IntegerDomain)
  SByC::R::Numeric.refine(:Float,   SByC::R::FloatDomain)

SByC::R::Alpha.refine(:String, SByC::R::StringDomain)
SByC::R::Alpha.refine(:Time,   SByC::R::TimeDomain)
SByC::R::Alpha.refine(:Date,   SByC::R::DateDomain)
SByC::R::Alpha.refine(:Symbol, SByC::R::SymbolDomain)
SByC::R::Alpha.refine(:Regexp, SByC::R::RegexpDomain)
SByC::R::Alpha.refine(:Module, SByC::R::ModuleDomain)

SByC::R::Alpha.refine(:Expression, SByC::R::ExpressionDomain)

SByC::R::Array        = SByC::R::DomainGenerator::Array.new
SByC::R::ArrayOfAlpha = SByC::R::Alpha.refine(SByC::R::Array[SByC::R::Alpha])


# SByC::R::DomainGenerator::Builder.new(SByC::R){
#   Union(:Alpha){
#     Builtin(:Domain)
#     Builtin(:Boolean)
#     Builtin(:Symbol)
#     Union(:Numeric){
#       Builtin(:Integer)
#       Builtin(:Float)
#     }
#     Builtin(:String)
#     Builtin(:Regexp)
#     Builtin(:Date)
#     Builtin(:Time)
#     Builtin(:Module)
#     Builtin(:Expression)
#   }
#   ArrayOf(:Alpha)
# }