SByC::R::install{|s|
  s.wrap_operator [:plus,  :+], [s::Integer, s::Integer], s::Integer
  s.wrap_operator [:minus, :-], [s::Integer, s::Integer], s::Integer
  s.wrap_operator [:times, :*], [s::Integer, s::Integer], s::Integer
}
