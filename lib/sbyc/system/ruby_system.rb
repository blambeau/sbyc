::SByC::RubySystem = ::SByC::System.new {|t|

  # Some standard unary operators on strings
  t.add_operator(:capitalize, [[String], String],  "$0.capitalize()")
  t.add_operator(:downcase,   [[String], String],  "$0.downcase()")
  t.add_operator(:empty?,     [[String], Boolean], "$0.empty?()")
  t.add_operator(:hashcode,   [[String], Integer], "$0.hash()")
  t.add_operator(:length,     [[String], Integer], "$0.length()")
  t.add_operator(:reverse,    [[String], Integer], "$0.reverse()")
  t.add_operator(:rstrip,     [[String], String],  "$0.rstrip()")
  t.add_operator(:strip,      [[String], String],  "$0.strip()")
  t.add_operator(:to_i,       [[String], String],  "$0.to_i()")
  t.add_operator(:to_f,       [[String], String],  "$0.to_f()")
  t.add_operator(:to_s,       [[String], String],  "$0")
  t.add_operator(:upcase,     [[String], String],  "$0.upcase()")

  # Some standard binary operators on strings
  t.add_operator([:at, :slice], [[String, Fixnum], String],  "$0.slice($1)")
  t.add_operator([:at, :slice], [[String, Range], String],  "$0.slice($1)")
  t.add_operator(:center,       [[String, Integer], String],  "$0.center($1)")
  t.add_operator(:concat,       [[String, String],  String],  "$0.+($1)")
  t.add_operator(:format,       [[String, String],  String],  "$0.%($1)")
  t.add_operator(:include?,     [[String, String],  Boolean], "$0.include?($1)")
  t.add_operator(:matches?,     [[String, Regexp],  Boolean], "(!!$0.=~($1))")
  t.add_operator(:times,        [[String, Integer], String],  "$0.*($1)")

  # Some standard ternary operators on strings
  t.add_operator(:sub,        [[String, Regexp, String], String],  "$0.sub($1, $2)")
  t.add_operator(:gsub,       [[String, Regexp, String], String],  "$0.gsub($1, $2)")

  # Comparisons
  [Numeric, String].each do |type|
    signature = ::SByC::System::Signature.coerce([[type, type], Boolean])
    t.add_operator(:eq,   signature, "$0.==($1)")
    t.add_operator(:lt,   signature, "$0.<($1)")
    t.add_operator(:lte,  signature, "$0.<=($1)")
    t.add_operator(:gt,   signature, "$0.>($1)")
    t.add_operator(:gte,  signature, "$0.>=($1)")
  end

  # Arithmetic operators on numerics
  t.add_operator(:plus,  [[Integer, Integer], Integer], "$0+$1")
  t.add_operator(:minus, [[Integer, Integer], Integer], "$0-$1")
  t.add_operator(:times, [[Integer, Integer], Integer], "$0*$1")


}
