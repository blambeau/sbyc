module Logic
  module Finite
    class AllBut < Finite::FiniteTerm
    
      # Excluded value
      attr_reader :values
    
      # Creates an Allbut instance
      def initialize(variable, values)
        super(variable)
        @values = values
      end
    
      # Computes boolean negation
      def bool_not
        Finite::belongs_to(variable, values)
      end
    
      # Computes a boolean conjunction
      def bool_and(term)
        if term.kind_of?(FiniteTerm) && term.variable == variable
          case term
            when None
              term
            when Any
              self
            when AllBut
              # not(in(x, y)) & not(in(y, z)) -> not(in(x,y) | in(y,z))
              #                               -> not(in(x,y | y,z))
              Finite::allbut(variable, (values | term.values))
            when BelongsTo
              # not(in(x, y)) & in(y, z) -> in(y-z - x,y)
              #                          -> in(z)
              Finite::belongs_to(variable, (term.values - values))
            else
              super
          end
        else
          super
        end
      end
    
      # Computes a boolean disjunction
      def bool_or(term)
        if term.kind_of?(FiniteTerm) && term.variable == variable
          case term
            when None
              self
            when Any
              term
            when AllBut
              # not(in(x, y)) | not(in(y, z)) -> not(in(x, y) & in(y, z))
              #                               -> not(in(y))
              Finite::allbut(variable, values & term.values)
            when BelongsTo
              # not(in(x,y)) | in(y,z) -> not(in(x,y) & not(in(y,z)))
              #                        -> not(in(x,y - y,z))
              Finite::allbut(variable, values - term.values)
            else
              super
          end
        else
          super
        end
      end
    
      # Computes equality with another term
      def ==(other)
        other.kind_of?(AllBut) && 
        (other.variable == variable) &&
        (other.values.size == values.size) &&
        ((other.values & values) == values)
      end
    
      # Returns a string representation
      def to_s
        "#{variable}: not(in(#{values.join(', ')}))"
      end
      alias :inspect :to_s
    
    end # class Allbut
  end # module Finite
end # module Logic
    
