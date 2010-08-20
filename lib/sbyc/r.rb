require 'time'
require 'date'
require 'enumerator'
require 'sbyc/r/robustness'
require 'sbyc/r/callable'
require 'sbyc/r/parser'
require 'sbyc/r/abstract_domain'
require 'sbyc/r/domain_generator'
module SByC
  module R
    extend R::Robustness
    
    def self_runner
      @self_runner ||= R::Runner.new
    end
    
    def install_on_self
      runner = self_runner
      exprs  = parse(File.read(File.expand_path('../r/core.el', __FILE__)), :multiline => true)
      exprs.each{|expr| value = runner.evaluate(expr) }
      runner.each_global{|name, global|
        if name.to_s =~ /^[A-Z]/
          const_set(name, global)
        end
      }
    end
    
    def domains
      runner = self_runner
      domains = []
      runner.each_global{|name, global|
        if runner.looks_a_domain?(global)
          domains << global
        end
      }
      domains
    end
    
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
    
    extend(R)
  end # module R
end # module SByC
require 'sbyc/r/namespace'
require 'sbyc/r/runner'
