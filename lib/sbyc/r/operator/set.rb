module SByC
  module R
    class Operator
      module Set
        
        # Factors an operator set
        def self.factor(domain = nil, &block)
          c = ::Module.new
          c.extend(ClassMethods)
          c.define(&block) if block
          c
        end

        module ClassMethods

          # Returns unbound
          def _
            R::Operator::Signature::MATCHING_TERM
          end

          # Returns installed operators
          def operators
            @operators ||= {}
          end
        
          ### About operator definition #########################################
          
          # Adds an operator
          def add_operator(op)
            op.aliases.each{|name| operators[name] = op}
          end
        
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
              add_operator(@op)
              @op = nil
            end
          end
  
          ### About operator retrieval ##########################################

          # Find an operator that matches a given signature
          def find_operator(name, signature, requester = nil)
            (op = operators[name]) && 
              op.signature_matches?(signature, requester) ? op : nil
          end

        end # module ClassMethods
        
      end # module Set
    end # class Operator
  end # module R
end # module SByC