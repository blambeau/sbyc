module SByC
  module Typing
    module R
      class Domain
        module OperatorMethods
          
          # Returns the operators, by name
          def operators
            @operators ||= {}
          end
          
          # Adds a operator
          def add_operator(names, operator)
            names.each{|n| operators[n] = operator}
            operator
          end
          
          # Adds a monadic operator with a proc
          def add_monadic_operator(names, return_type, &proc)
            names = [names] unless names.kind_of?(Array)
            add_operator(names, ProcOperator.new([self], return_type, proc))
          end
          
          def wrap_ruby_monadic_operator(names, return_type = self)
            names = [names] unless names.kind_of?(Array)
            add_operator(names, WrappedOperator.new([self], return_type, names.last))
          end
      
          def wrap_ruby_dyadic_operator(names, operand_type, return_type = self)
            names = [names] unless names.kind_of?(Array)
            add_operator(names, WrappedOperator.new([self, operand_type], return_type, names.last))
          end

        end # module OperatorMethods
      end # class Domain
    end # module R
  end # module Typing
end # module SByC

