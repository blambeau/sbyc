SByC::R::install{|s|
  s.wrap_operator :capitalize, [s::String], s::String
  s.wrap_operator :downcase,   [s::String], s::String
  s.wrap_operator :empty?,     [s::String], s::Boolean
  s.wrap_operator :length,     [s::String], s::Integer
  s.wrap_operator :reverse,    [s::String], s::String
  s.wrap_operator :rstrip,     [s::String], s::String
  s.wrap_operator :strip,      [s::String], s::String
  s.wrap_operator :to_i,       [s::String], s::Integer
  s.wrap_operator :to_f,       [s::String], s::Float
  s.wrap_operator :to_s,       [s::String], s::String
  s.wrap_operator :upcase,     [s::String], s::String

  # Some standard binary operators on strings
  s.wrap_operator :center,      [s::String, s::Integer], s::String
  s.wrap_operator :format,      [s::String, s::String],  s::String
  s.wrap_operator :include?,    [s::String, s::String],  s::Boolean
  s.wrap_operator [:times, :*], [s::String, s::Integer], s::String

  # Aggregation operators
  s.aggregate_operator [:concat, :+], s::String, ""
}
