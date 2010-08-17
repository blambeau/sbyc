class SByC::R::DomainGenerator::Builtin
  module ExpressionDomain
    module ClassMethods
    
      EXAMPLAR_CODES = [
        "(Expression (Boolean true))"
      ]
    
      def exemplars
        EXAMPLAR_CODES.collect{|str| parse_literal(str)}
      end
    
      def is_value?(value)
        value.class == self
      end

      def parse_literal(str)
        if str =~ /^\(Expression /
          o = system::evaluate({}, str)
          if is_value?(o)
            o
          else
            __not_a_literal__!(self, str)
          end
        else
          __not_a_literal__!(self, str)
        end
      end

      def to_literal(value)
        value.to_s
      end
    
      def coerce(x)
        if is_value?(x)
          x
        elsif x.kind_of?(::String)
          parse_literal(x)
        elsif x.kind_of?(CodeTree::AstNode)
          self.new(x)
        else
          super
        end
      end
      
    end
    module InstanceMethods
      
      # The asbtract syntax tree
      attr_reader :ast
      
      # Creates an expression instance
      def initialize(ast)
        @ast = ast
      end
      
      # Evaluates this expression on a given context
      def evaluate(context = {})
        self.class.system.evaluator(ast).evaluate(context)
      end
      
      def to_s
        "(Expression #{ast.to_s})"
      end
      
      def ==(other)
        other.kind_of?(self.class) and other.ast == self.ast
      end
      
    end
  end # module ExpressionDomain
end # class SByC::R::DomainGenerator::Builtin