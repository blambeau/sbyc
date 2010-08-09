SByC::R::install{|s|
  s.add_structure s::Integer, s::Ordered
  s.wrap_operator [:minus, :-], [s::Integer, s::Integer], s::Integer
  s.aggregate_operator [:plus, :+],  s::Integer, 0
  s.aggregate_operator [:times, :*], s::Integer, 1
}
