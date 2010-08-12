module SByC
  module R
    module ExpressionDomain
      module ClassMethods
      
        EXAMPLAR_CODES = [
          "(Boolean true)"
        ]
      
        def exemplars
          EXAMPLAR_CODES.collect{|str| parse_literal(str)}
        end
      
        def is_value?(value)
          value.class == self
        end
  
        def parse_literal(str)
          self.new(SByC::R::Parser.new(str).parse(:eof => true))
        rescue CodeTree::ParseError
          __not_a_literal__!(self, str)
        end
  
        def to_literal(value)
          value.to_s
        end
      
        def coerce(x)
          if is_value?(x)
            x
          elsif x.kind_of?(String)
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
          R::Evaluator.new(ast).evaluate(context)
        end
        
        def to_s
          ast.to_s
        end
        
        def ==(other)
          other.kind_of?(self.class) and other.ast == self.ast
        end
        
      end
    end # module ExpressionDomain
  end # module R
end # module SByC
