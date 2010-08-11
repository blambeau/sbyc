module SByC
  module R
    module AbstractDomain
      class OperatorSet
        
        # Factors an operator set
        def self.factor(domain)
          c = Class.new.extend(ClassMethods)
          c.__set_domain__(domain)
          c
        end

        module ClassMethods

          # Sets the domain
          def __set_domain__(domain)
            @__domain__ = domain
          end

          # Returns installed operators
          def operators
            @operators ||= {}
          end
        
          # Returns an instance of self for binding operator
          # methods
          def instance
            @instance ||= self.new
          end
        
          ### About operator definition #########################################
        
          # Installs the informations about the next operator to add
          def operator(&block)
            yield(@op = R::Operator.new) 
          end

          # Defines a set of operators
          def define(&block)
            module_eval(&block)
          end

          # Callback when a new operator is installed
          def method_added(p)
            if @op
              @op.method = instance_method(p).bind(self.instance)
              @op.aliases.each{|name| operators[name] = @op}
              @op = nil
            end
          end
  
          ### About operator retrieval ##########################################

          # Find an operator that matches a given signature
          def find_operator(name, signature)
            ops = operators
            if ops.key?(name) 
              op = ops[name]
              op.signature_matches?(signature) ? op : nil
            elsif @__domain__
              @__domain__.super_domains.each{|dom|
                op = dom::Operators.find_operator(name, signature)
                return op unless op.nil?
              }
              nil
            else
              nil
            end
          end

        end
        
      end # module OperatorSet
    end # module AbstractDomain
  end # module R
end # module SByC