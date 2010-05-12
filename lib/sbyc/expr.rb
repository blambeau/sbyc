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
    
    # Evaluates this AST with an object style.
    def object_eval(scope = {}) 
      ast.visit{|node, collected|
        case func = node.function
          when :'_'
            collected.first
          when :'?'
            scope[*collected]
          else
            collected[0].send(func, *collected[1..-1])
        end
      }
    end
    alias :eval :object_eval
    alias :call :object_eval
    
    # Evaluates this AST with an object style.
    def functional_eval(master_object, scope = {}) 
      ast.visit{|node, collected|
        case func = node.function
          when :_
            collected.first
          when :'?'
            scope[*collected]
          else
            master_object.send(func, *collected)
        end
      }
    end
    alias :apply :functional_eval
    
    # Returns a string representation
    def to_s
      ast.to_s
    end
    
  end # class Expr
end # module SByC