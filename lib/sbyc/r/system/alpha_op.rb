SByC::R::install{|s|
  s.wrap_operator [:equals?, :==], [s::Alpha, s::Alpha], s::Boolean, lambda{|args|
    v1, v2 = args
    (R::domain_of(v1) == R::domain_of(v2)) && (v1 == v2)
  }
}