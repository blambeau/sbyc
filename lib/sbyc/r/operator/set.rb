module SByC
  module R
    class Operator
      module Set
        
        # Factors an operator set
        def self.factor(system, &block)
          c = ::Module.new
          c.extend(ClassMethods)
          c.system = system
          c.define(&block) if block
          c
        end

        module ClassMethods
          include SByC::R::Operator::Signature::Factory
          
          # The system
          attr_accessor :system

          # Returns unbound
          def _
            R::Operator::Signature::MATCHING_TERM
          end

          # Returns installed operators
          def operators
            @operators ||= Hash.new{|h,k| h[k] = []}
          end
          
          def each_operator
            @operators.each_pair{|name, ops|
              ops.each{|op| yield(name, op)}
            }
          end
        
          ### About operator definition #########################################
          
          # Adds an operator
          def add_operator(op)
            op.aliases.each{|name| operators[name] << op}
          end
        
          # Installs the informations about the next operator to add
          def operator(&block)
            yield(@op = R::Operator.new) 
          end
          
          # Defines a set of operators
          def define(&block)
            module_eval(&block)
            extend(self)
            each_operator{|name, op|
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
          def find_operator_by_signature(name, signature, requester = nil)
            if operators.key?(name)
              operators[name].find{|op| op.signature_matches?(signature, requester)}
            else
              nil
            end
          end

          # Find an operator that matches a given signature
          def find_operator_by_args(name, args, requester = nil)
            if operators.key?(name)
              operators[name].find{|op| op.arg_matches?(args, requester)}
            else
              nil
            end
          end

        end # module ClassMethods
        
      end # module Set
    end # class Operator
  end # module R
end # module SByC