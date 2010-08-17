SByC::R::builder.run{
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
  Builtin(:Expression)
  Builtin(:Heading)
  Reuse(:Matcher, SByC::R::Operator::Matcher){
    Reuse(:DomainMatcher, SByC::R::Operator::DomainMatcher)
    Reuse(:PlusMatcher, SByC::R::Operator::PlusMatcher)
    Reuse(:StarMatcher, SByC::R::Operator::StarMatcher)
    Reuse(:SeqMatcher, SByC::R::Operator::SeqMatcher)
  }
  Reuse(:Signature, SByC::R::Operator::Signature)
  Reuse(:Operator,  SByC::R::Operator)
  Builtin(:Module)
  ArrayOf(:Alpha)
}