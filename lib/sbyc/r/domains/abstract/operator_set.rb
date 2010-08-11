module SByC
  module R
    module AbstractDomain
      module OperatorSet
        
        # Factors an operator set
        def self.factor(domain = nil, &block)
          c = ::Module.new
          c.extend(ClassMethods)
          c.__prepare__(domain)
          c.define(&block) if block
          c
        end

        module ClassMethods

          # Returns unbound
          def _
            R::Operator::Signature::MATCHING_TERM
          end

          # Sets the domain
          def __prepare__(domain)
            @__domain__ = domain
          end

          # Returns installed operators
          def operators
            @operators ||= {}
          end
        
          ### About operator definition #########################################
        
          # Installs the informations about the next operator to add
          def operator(&block)
            yield(@op = R::Operator.new) 
          end

          # Defines a set of operators
          def define(&block)
            module_eval(&block)
            extend(self)
            operators.each_pair{|name, op| 
              if op.method.kind_of?(::UnboundMethod)
                op.method = op.method.bind(self)
              end
            }
            self
          end

          # Callback when a new operator is installed
          def method_added(p)
            if @op
              @op.method = instance_method(p)
              @op.aliases.each{|name| operators[name] = @op}
              @op = nil
            end
          end
  
          ### About operator retrieval ##########################################

          # Find an operator that matches a given signature
          def find_operator(name, signature, requester = nil)
            (op = operators[name]) && 
              op.signature_matches?(signature, requester) ? op : nil
          end

        end
        
      end # module OperatorSet
    end # module AbstractDomain
  end # module R
end # module SByC