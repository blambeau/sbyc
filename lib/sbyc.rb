module SByC

  # Version
  VERSION = "0.2.0".freeze
  
  # Provides tools around functional source code trees.
  module CodeTree
    
  end # module CodeTree

  # Provides tools around type system abstractions
  module TypeSystem
    
  end # module CodeTree
  
end # module SByC
require 'sbyc/errors'
require 'sbyc/codetree'
require 'sbyc/type_system'
require 'sbyc/typing'
SByC::TypeSystem::Ruby::deprecated = true