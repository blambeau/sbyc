SByC::R::install{|s|
  s.wrap_operator [:plus,  :+], [s::Float, s::Float],   s::Float
  s.wrap_operator [:plus,  :+], [s::Float, s::Integer], s::Float
  s.wrap_operator [:plus,  :+], [s::Integer, s::Float], s::Float
  s.wrap_operator [:minus, :-], [s::Float, s::Float],   s::Float
  s.wrap_operator [:minus, :-], [s::Float, s::Integer], s::Float
  s.wrap_operator [:minus, :-], [s::Integer, s::Float], s::Float
  s.wrap_operator [:times, :*], [s::Float, s::Float],   s::Float
  s.wrap_operator [:times, :*], [s::Float, s::Integer], s::Float
  s.wrap_operator [:times, :*], [s::Integer, s::Float], s::Float
}
