require 'time'
require 'date'
require 'sbyc/r/robustness'
require 'sbyc/r/parser'
require 'sbyc/r/class_methods'
require 'sbyc/r/factory'
require 'sbyc/r/operator'
module SByC
  module R
    extend R::Robustness
    extend R::ClassMethods
    extend R::Factory
    
    # Parses some code and returns an Ast
    def parse(code, options = nil, &block)
      code = code || block
      if code.kind_of?(CodeTree::AstNode)
        code
      elsif code.kind_of?(Proc)
        CodeTree::parse(code, options)
      else
        R::Parser.new(code).parse(options || {})
      end
    end
    
    def domains
      Builtin.domains + Array.domains
    end
        
    extend(R)
  end # module R
end # module SByC
require 'sbyc/r/system'