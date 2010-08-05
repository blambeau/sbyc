module SByC

  # Version
  VERSION = "0.1.4".freeze
  
  # Provides tools around functional source code trees.
  module CodeTree
    
  end # module CodeTree

  # Provides tools around type system abstractions
  module TypeSystem
    
  end # module CodeTree

  # Provides tools around predicates
  module Formulae
    
  end # module Formulae
  
end # module SByC

CodeTree = ::SByC::CodeTree
require 'sbyc/codetree'

TypeSystem = ::SByC::TypeSystem
require 'sbyc/type_system'

Formulae = ::SByC::Formulae
require 'sbyc/formulae'
