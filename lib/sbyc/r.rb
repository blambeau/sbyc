require 'time'
require 'date'
require 'sbyc/r/robustness'
require 'sbyc/r/parser'
require 'sbyc/r/class_methods'
require 'sbyc/r/operator'
require 'sbyc/r/abstract_domain'
require 'sbyc/r/domain_generator'
module SByC
  module R
    extend R::Robustness
    extend R::ClassMethods
    
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
    
    # Returns the set of system operators
    def operators
      @operators ||= SByC::R::Operator::Set.factor(self)
    end
    
    # Returns the builder
    def builder
      @builder ||= DomainGenerator::Builder.new(self)
    end
    
    # Returns an evaluator
    def evaluator(ast)
      R::Evaluator.new(ast, self)
    end
    
    def domains_hash
      @domains_hash ||= {}
    end
    
    def domains
      domains_hash.values
    end
    
    def fed(name)
      self.const_get(name)
    end
    
    # Callback of a builder when domains are created
    def domain_created(name, domain)
      domains_hash[name] = domain
      
      # Install constants and global selectors
      if name.to_s =~ /^[A-Z][a-z]*$/
        const_set(name, domain) unless const_defined?(name)
      end

      unless name == :Alpha
        op = Operator.new{|op|
          op.description = %Q{ Selector for #{name} }
          op.signature   = domain.selector_signature
          op.argnames    = [:operand]
          op.returns     = domain
          op.aliases     = [name]
          op.method      = lambda{|x| domain.coerce(x)}
        }
        operators.add_operator(op)
      end

      domain
    end
    
    def scalar_domain(args)
      heading = Hash[*args]
      builder.Scalar(:unnamed, heading)
    end
        
    extend(R)
  end # module R
end # module SByC
require 'sbyc/r/system'
require 'sbyc/r/running'
require 'sbyc/r/runner'