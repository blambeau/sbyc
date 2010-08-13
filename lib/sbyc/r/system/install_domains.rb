SByC::R::Builtin = SByC::R::DomainGenerator::Builtin.new
    
SByC::R::Builtin[:Alpha, [SByC::R::DomainGenerator::Tools::UnionDomain, SByC::R::DomainGenerator::Builtin::AlphaDomain]]
SByC::R::Alpha.refine(:Domain, SByC::R::DomainGenerator::Builtin::DomainDomain)

SByC::R::Alpha.refine(:Boolean, SByC::R::DomainGenerator::Builtin::BooleanDomain)

SByC::R::Alpha.refine(:Numeric, SByC::R::DomainGenerator::Tools::UnionDomain, SByC::R::DomainGenerator::Builtin::NumericDomain)
  SByC::R::Numeric.refine(:Integer, SByC::R::DomainGenerator::Builtin::IntegerDomain)
  SByC::R::Numeric.refine(:Float,   SByC::R::DomainGenerator::Builtin::FloatDomain)

SByC::R::Alpha.refine(:String, SByC::R::DomainGenerator::Builtin::StringDomain)
SByC::R::Alpha.refine(:Time,   SByC::R::DomainGenerator::Builtin::TimeDomain)
SByC::R::Alpha.refine(:Date,   SByC::R::DomainGenerator::Builtin::DateDomain)
SByC::R::Alpha.refine(:Symbol, SByC::R::DomainGenerator::Builtin::SymbolDomain)
SByC::R::Alpha.refine(:Regexp, SByC::R::DomainGenerator::Builtin::RegexpDomain)
SByC::R::Alpha.refine(:Module, SByC::R::DomainGenerator::Builtin::ModuleDomain)

SByC::R::Alpha.refine(:Expression, SByC::R::DomainGenerator::Builtin::ExpressionDomain)

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