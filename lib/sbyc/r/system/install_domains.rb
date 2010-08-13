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