SByC::R::install{|s|
  
  #
  # Equality operator
  #
  # (equals? Alpha, Alpha) -> Boolean
  #
  s.wrap_operator [:equals?, :==], [s::Alpha, s::Alpha], s::Boolean, lambda{|args| v1, v2 = args;
    (R::domain_of(v1) == R::domain_of(v2)) && (v1 == v2)
  }
  
  #
  # Type introspection operator
  #
  # (domain Alpha) -> Domain 
  #
  s.wrap_operator [:domain],  [s::Alpha], s::Domain, lambda{|args| s::Alpha.most_specific_domain_of(args.first)}
  
  #
  # Type checking operator
  #
  # (domain? Alpha Domain) -> Boolean
  #
  s.wrap_operator [:domain?], [s::Alpha, s::Domain], s::Boolean, lambda{|args| value, domain = args;
    domain.is_value?(value) == true
  }
  
}