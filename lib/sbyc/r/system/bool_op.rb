SByC::R::install{|s|
 s.wrap_operator [:not, :~], [s::Boolean], s::Boolean, lambda{|v| !v} 
 s.wrap_operator [:and, :&], [s::Boolean, s::Boolean], s::Boolean
 s.wrap_operator [:or,  :|], [s::Boolean, s::Boolean], s::Boolean
}