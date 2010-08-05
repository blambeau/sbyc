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
      def _bool_and(term)
        case term
          when AllBut
            # not(in(x, y)) & not(in(y, z)) -> not(in(x,y) | in(y,z))
            #                               -> not(in(x,y | y,z))
            Finite::allbut(variable, (values | term.values))
          when BelongsTo
            # not(in(x, y)) & in(y, z) -> in(y-z - x,y)
            #                          -> in(z)
            Finite::belongs_to(variable, (term.values - values))
          else
            raise "Unexpected term #{term.class}"
        end
      end
    
      # Computes a boolean disjunction
      def _bool_or(term)
        case term
          when AllBut
            # not(in(x, y)) | not(in(y, z)) -> not(in(x, y) & in(y, z))
            #                               -> not(in(y))
            Finite::allbut(variable, values & term.values)
          when BelongsTo
            # not(in(x,y)) | in(y,z) -> not(in(x,y) & not(in(y,z)))
            #                        -> not(in(x,y - y,z))
            Finite::allbut(variable, values - term.values)
          else
            raise "Unexpected term #{term.class}"
        end
      end
    
      # Evaluates this formula on a context object
      # (typically a variable assignment)
      def evaluate(context)
        if context[variable.name].nil?
          raise SByC::NilError, "Missing variable #{variable.name}"
        end
        !values.include?(context[variable.name])
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
        "~(#{variable.name}.in(#{values.join(', ')}))"
      end
      alias :inspect :to_s
    
    end # class Allbut
  end # module Finite
end # module Logic
    
