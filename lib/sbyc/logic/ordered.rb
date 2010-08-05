require 'sbyc/logic/ordered/interval'
require 'sbyc/logic/ordered/ordered_term'
require 'sbyc/logic/ordered/any'
require 'sbyc/logic/ordered/none'
require 'sbyc/logic/ordered/ranged'
module Logic
  module Ordered
    
    # Builds an Any term
    def any(var)
      Any.new(var)
    end
    
    # Builds a None term
    def none(var)
      None.new(var)
    end
    
    # Creates a ranged term
    def ranged(var, interval)
      if interval.empty?
        none(var)
      elsif interval.all?
        any(var)
      else
        Ordered::Ranged.new(var, interval)
      end
    end
    
    # Factors a between term
    def between(var, x, y)
      ranged(var, Interval.natural(x, y))
    end
  
    # Factors a eq term
    def eq(var, x)
      ranged(var, Interval.point(x))
    end
  
    # Factors a gt term
    def gt(var, x)
      ranged(var, Interval.gt(x))
    end
  
    # Factors a gte term
    def gte(var, x)
      ranged(var, Interval.gte(x))
    end
  
    # Factors a gt term
    def lt(var, x)
      ranged(var, Interval.lt(x))
    end
  
    # Factors a gte term
    def lte(var, x)
      ranged(var, Interval.lte(x))
    end
  
    extend(Ordered)
  end # module Ordered
end # module Logic