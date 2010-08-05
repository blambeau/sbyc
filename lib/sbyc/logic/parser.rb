module Logic
  class Parser
    
    class Receiver
      
      def is_var!(var)
        raise "Unexpected left operand #{var}" unless var.kind_of?(Variable)
      end
      
      def is_formula!(f)
        raise "Unexpected operand #{f}" unless f.kind_of?(Formula)
      end
      
      def are_formulae!(*operands)
        operands.all?{|op| is_formula!(op)}
      end

      def eq(var, literal) 
        is_var!(var)
        Logic::Ordered::eq(var, literal)
      end
      
      def gt(var, literal) 
        is_var!(var)
        Logic::Ordered::gt(var, literal)
      end
      
      def gte(var, literal) 
        is_var!(var)
        Logic::Ordered::gte(var, literal)
      end
      
      def lt(var, literal) 
        is_var!(var)
        Logic::Ordered::lt(var, literal)
      end
      
      def lte(var, literal) 
        is_var!(var)
        Logic::Ordered::lte(var, literal)
      end
      
      def bool_and(left, right) 
        are_formulae!(left, right)
        left.bool_and(right)
      end
      
      def bool_or(left, right) 
        are_formulae!(left, right)
        left.bool_or(right)
      end
      
      def bool_not(left) 
        is_formula!(left)
        left.bool_not
      end
      
    end
    
    SYMBOL_TO_FUNCTION = {
      :'>'  => :gt,
      :'>=' => :gte,
      :'<'  => :lt,
      :'<=' => :lte,
      :'==' => :eq,
      :'&'  => :bool_and,
      :'|'  => :bool_or,
      :'~'  => :bool_not
    }
    
    # Type system to use
    attr_reader :type_system
    
    # Creates a parser instance
    def initialize(type_system)
      @type_system = type_system
      @vars = {}
    end
    
    # Creates variable instance
    def [](name)
      @vars[name] ||= Logic::Variable.new(name, Integer)
    end
    
    # Parses an expression and returns a Formula
    def parse(expr = nil, &block)
      ast = CodeTree::parse(expr || block)
      ast.rename!(SYMBOL_TO_FUNCTION)
      ast.functional_eval(Receiver.new, self)
    end
    
  end # class Parser
end # module Logic