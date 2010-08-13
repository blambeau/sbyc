SByC::R::Builtin = SByC::R::DomainGenerator::Builtin.new
    
SByC::R::Builtin.generate(:Alpha, [SByC::R::DomainGenerator::Tools::UnionDomain, SByC::R::DomainGenerator::Builtin::AlphaDomain])
SByC::R::Alpha.refine(:Domain)
SByC::R::Alpha.refine(:Boolean)
SByC::R::Alpha.refine(:Numeric, SByC::R::DomainGenerator::Tools::UnionDomain, SByC::R::DomainGenerator::Builtin::NumericDomain)
  SByC::R::Numeric.refine(:Integer)
  SByC::R::Numeric.refine(:Float)
SByC::R::Alpha.refine(:String)
SByC::R::Alpha.refine(:Time)
SByC::R::Alpha.refine(:Date)
SByC::R::Alpha.refine(:Symbol)
SByC::R::Alpha.refine(:Regexp)
SByC::R::Alpha.refine(:Module)
SByC::R::Alpha.refine(:Expression)

SByC::R::Array        = SByC::R::DomainGenerator::Array.new
SByC::R::ArrayOfAlpha = SByC::R::Alpha.refine(SByC::R::Array.generate(SByC::R::Alpha))


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