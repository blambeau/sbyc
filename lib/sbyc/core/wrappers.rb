::SByC::BUILTIN_TYPES.each do |type|
  type.extend(::SByC::BuiltinType)
  ::SByC::System.add_type(type)
end
