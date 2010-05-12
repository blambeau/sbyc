module SByC
  class Expr
    
    # Abstract Syntax Tree
    attr_reader :ast
    
    # Creates a proc instance
    def initialize(ast)
      @ast = ast
    end
    
    # Coerce to a proc
    def self.coerce(code = nil, &block)
      case code = (code || block)
        when Expr
          code
        else
          Expr.new(::SByC::parse(code))
      end
    end
    
    # Executes this proc within a scope object
    def eval(scope = {})
      ast.object_eval(scope)
    end
    alias :call :eval
    
    # Returns a string representation
    def to_s
      "::SByC::expr{ #{ast} }"
    end
    
  end # class Expr
end # module SByC