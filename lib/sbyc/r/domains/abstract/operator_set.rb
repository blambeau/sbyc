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
            lambda{ @__domain__ }
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
          def find_operator(name, signature)
            # first case, an operator with that name exists in
            # the operators themselve
            if operators.key?(name) 
              op = operators[name]
              return op if op.signature_matches?(signature)
            end
            
            # if there is no attached domain, the operator does 
            # not exist (on structures, typically)
            return nil unless @__domain__
            
            # second case, an operator with that name exists
            # in a domain structure
            @__domain__.each_structure{|structure|
            }
            
            # third case, the operator exists in a super domain
            @__domain__.each_super_domain{|dom|
              op = dom::Operators.find_operator(name, signature)
              return op unless op.nil?
            }
            # nothing found
            nil
          end

        end
        
      end # module OperatorSet
    end # module AbstractDomain
  end # module R
end # module SByC