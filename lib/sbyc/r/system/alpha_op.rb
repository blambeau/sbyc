SByC::R::install{|s|
  
  #
  # Equality operator
  #
  # (equals? Alpha, Alpha) -> Boolean
  #
  s.wrap_operator [:equals?, :==], [s::Alpha, s::Alpha], s::Boolean, lambda{|v1, v2|
    (R::domain_of(v1) == R::domain_of(v2)) && (v1 == v2)
  }
  
  #
  # Type introspection operator
  #
  # (domain Alpha) -> Domain 
  #
  s.wrap_operator [:domain],  [s::Alpha], s::Domain, lambda{|operand| s::Alpha.most_specific_domain_of(operand)}
  
  #
  # Type checking operator
  #
  # (domain? Alpha Domain) -> Boolean
  #
  s.wrap_operator [:domain?], [s::Alpha, s::Domain], s::Boolean, lambda{|value, domain|
    domain.is_value?(value) == true
  }
  
}