SByC::R::Builtin = SByC::R::DomainGenerator::Builtin.new
    
SByC::R::DomainGenerator::Builder.new(SByC::R){
  Builtin(:Alpha){
    Builtin(:Domain)
    Builtin(:Boolean)
    Builtin(:Symbol)
    Builtin(:Numeric){
      Builtin(:Integer)
      Builtin(:Float)
    }
    Builtin(:String)
    Builtin(:Regexp)
    Builtin(:Date)
    Builtin(:Time)
    Builtin(:Module)
    Builtin(:Expression)
    ArrayOf(:Alpha)
  }
}

# SByC::R::Array        = SByC::R::DomainGenerator::Array.new
# SByC::R::ArrayOfAlpha = SByC::R::Alpha.refine(SByC::R::Array.generate(SByC::R::Alpha))


