module SByC
  module R
    class RuntimeError < StandardError; end
    class Evaluator
      
      # System that executes this evaluator
      attr_reader :system
      
      # Creates an evaluator instance
      def initialize(ast, system)
        @ast = ast
        @system = system
      end
      
      def __undefined__(var_name, node)
        raise RuntimeError, "#{var_name} undefined"
      end
      
      def __no_such_operator_for_signature__(name, sign)
        signstr = sign.collect{|x| system::Domain.to_literal(x)}.join(' ')
        raise RuntimeError, "No such operator (#{name} #{signstr})"
      end
      
      def __no_such_operator_for_args__(name, args)
        signature = args.collect{|x| system::Alpha::domain_of(x)}
        __no_such_operator_for_signature__(name, signature)
      end
      
      # Finds an operator by name and specific arguments
      def find_operator_by_args(name, args)
        system.operators.find_operator_by_args(name, args) ||
        __no_such_operator_for_args__(name, args)
      end
      
      # Lauches evaluation
      def evaluate(context = {}, node = @ast)
        case func = node.function
          
          # Resolving a variable name
          when :'?'
            var_name = node.literal
            if context.has_key?(var_name)
              context[var_name]
            elsif f = find_operator_by_args(var_name, [])
              f.call([])
            else
              __undefined__(var_name, node)
            end
            
          # Resolving a true literal
          when :_
            node.literal
            
          # Resolving other functions
          else
            # evaluate the children and come back
            args = node.children.collect{|c| evaluate(context, c)}
            find_operator_by_args(func, args).call(args)
        end
      end
      
    end # class Evaluator
  end # module R
end # module SByC