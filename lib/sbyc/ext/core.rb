::SByC::BUILTIN_TYPES.each do |type|
  type.extend(::SByC::BuiltinType)
  type.instance_eval { include(::SByC::Value) }
end