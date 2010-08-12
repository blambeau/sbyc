require 'singleton'
module SByC
  module R
    class DomainGenerator
      class Builtin < DomainGenerator
        include Singleton
        
        def domain_created(name, domain)
          # Install the selector
          if R::const_defined?(:Alpha)
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
      
          super
        end
        
        #
        # Generates a builtin domain with a name, class methods
        # and values methods (both being array of modules)
        #
        def generate(name, class_methods = [], instance_methods = [])
          domain = Class.new
          ([R::AbstractDomain] + class_methods).flatten.each{|mod|
            domain.extend(mod)
          }
          (instance_methods).flatten.each{|mod|
            domain.instance_eval{ include(mod) }
          }
          domain.domain_generator = self
          domain.const_set(:Operators, R::Operator::Set.factor)
          domain_created(name, domain)
        end
        alias :[] :generate
        
      end # class Builtin
    end # class DomainGenerator
  end # module R
end # module SByC