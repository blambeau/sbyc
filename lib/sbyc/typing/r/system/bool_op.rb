SByC::Typing::R::install{|s|
 s::Boolean.add_monadic_operator      [:not, :~], s::Boolean, lambda{|v| !v} 
 s::Boolean.wrap_ruby_dyadic_operator [:and, :&], s::Boolean, s::Boolean
 s::Boolean.wrap_ruby_dyadic_operator [:or,  :|], s::Boolean, s::Boolean
}