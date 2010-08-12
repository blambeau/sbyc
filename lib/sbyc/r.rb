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
      @__domains__ ||= []
    end
    
    # Feedback from DomainDomain when a domain has been created
    def domain_created(name, domain)
      domains << domain

      # Install the selector
      if const_defined?(:Alpha)
        op = R::Operator.new{|op|
          op.description = %Q{ Selector for #{name} }
          op.signature   = [SByC::R::Alpha]
          op.argnames    = [:operand]
          op.returns     = domain
          op.aliases     = [name]
          op.method      = lambda{|x| domain.coerce(x)}
        }
        R::Alpha::Operators.add_operator(op)
      end
      
      # Returns created domain
      domain
    end
        
    extend(R)
  end # module R
end # module SByC

require 'sbyc/r/domains'
require 'sbyc/r/system/install_domains'
require 'sbyc/r/system/install_structures'
require 'sbyc/r/system/install_operators'
