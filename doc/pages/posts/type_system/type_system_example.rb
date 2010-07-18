TypeSystem::Ruby::type_of(-125)
# => Fixnum

lit = TypeSystem::Ruby::to_literal(-125)
# => "-125"

TypeSystem::Ruby::parse_literal("-125")
# => -125

TypeSystem::Ruby::coerce('-125', Integer)
# => -125