require 'sbyc/logic/finite/finite_term'
require 'sbyc/logic/finite/any'
require 'sbyc/logic/finite/none'
require 'sbyc/logic/finite/belongs_to'
require 'sbyc/logic/finite/allbut'
module Logic
  module Finite
    
    # Builds an Any term
    def any(var)
      Any.new(var)
    end
    
    # Builds a None term
    def none(var)
      None.new(var)
    end
    
    # Factors an AllBut term
    def allbut(var, values)
      values.empty? ? Any.new(var) : AllBut.new(var, values)
    end
    
    # Factors a BelongsTo term
    def belongs_to(var, values)
      values.empty? ? None.new(var) : BelongsTo.new(var, values)
    end
    
    extend(Finite)
  end # module Finite
end # module Logic