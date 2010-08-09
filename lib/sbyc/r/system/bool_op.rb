SByC::R::install{|s|
 s.wrap_operator [:complement,  :not, :~], [s::Boolean], s::Boolean, lambda{|value| !value} 
 s.wrap_operator [:conjunction, :and, :&], [s::Boolean, s::Boolean], s::Boolean
 s.wrap_operator [:disjunction, :or,  :|], [s::Boolean, s::Boolean], s::Boolean
}