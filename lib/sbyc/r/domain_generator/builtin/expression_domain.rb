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
    
      def call_signature
        [ [ CodeTree::AstNode ] ]
      end
      
      def coerce(runner, args, binding)
        case f = args.first
          when CodeTree::AstNode
            self.new(f)
          else
            call_error(runner, args, binding)
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
      
      def to_binding(arg)
        case arg
          when NilClass
            {}
          when ::Hash
            arg
          when ::Array
            context = {}
            arg.each_with_index{|a,i| context[:"$#{i}"] = a}
            context
          else
            raise "Unable to convert #{arg.inspect} to a context"
        end
      end
      
      # Evaluates this expression on a given context
      def evaluate(context = {})
        self.class.system.evaluator(ast).evaluate(to_binding(context))
      end
      
      def sbyc_call(runner, args, binding)
        runner.evaluate(ast, to_binding(args))
      end
      
      def to_s
        "(Expression #{ast.to_s})"
      end
      alias :inspect :to_s
      
      def ==(other)
        other.kind_of?(self.class) and other.ast == self.ast
      end
      
    end
  end # module ExpressionDomain
end # class SByC::R::DomainGenerator::Builtin