SByC::Typing::R::install{|s|
  s::String.wrap_ruby_monadic_operator :capitalize,    s::String
  s::String.wrap_ruby_monadic_operator :downcase,      s::String
  s::String.wrap_ruby_monadic_operator :empty?,        s::Boolean
  s::String.wrap_ruby_monadic_operator :length,        s::Integer
  s::String.wrap_ruby_monadic_operator :reverse,       s::String
  s::String.wrap_ruby_monadic_operator :rstrip,        s::String
  s::String.wrap_ruby_monadic_operator :strip,         s::String
  s::String.wrap_ruby_monadic_operator :to_i,          s::Integer
  s::String.wrap_ruby_monadic_operator :to_f,          s::Float
  s::String.wrap_ruby_monadic_operator :to_s,          s::String
  s::String.wrap_ruby_monadic_operator :upcase,        s::String

  # Some standard binary operators on strings
  s::String::wrap_ruby_dyadic_operator [:at, :slice], [s::Integer], s::String
  s::String::wrap_ruby_dyadic_operator :center,       [s::Integer], s::String
  s::String::wrap_ruby_dyadic_operator :concat,       [s::String],  s::String
  s::String::wrap_ruby_dyadic_operator :format,       [s::String],  s::String
  s::String::wrap_ruby_dyadic_operator :include?,     [s::String],  s::Boolean
  s::String::wrap_ruby_dyadic_operator :matches?,     [s::Regexp],  s::Boolean
  s::String::wrap_ruby_dyadic_operator :times,        [s::Integer], s::String

  # # Some standard ternary operators on strings
  # s::String::wrap_ruby_dyadic_operator :sub,        [[String, Regexp, String], String],  "$0.sub($1, $2)")
  # s::String::wrap_ruby_dyadic_operator :gsub,       [[String, Regexp, String], String],  "$0.gsub($1, $2)")
  # 
}
