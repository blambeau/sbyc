SByC::Typing::R::install{|s|
  s::Integer.wrap_ruby_dyadic_operator [:plus,  :+], s::Integer
  s::Integer.wrap_ruby_dyadic_operator [:minus, :-], s::Integer
  s::Integer.wrap_ruby_dyadic_operator [:times, :*], s::Integer
}
