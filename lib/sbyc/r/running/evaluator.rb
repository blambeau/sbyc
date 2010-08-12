module SByC
  module R
    class RuntimeError < StandardError; end
    class Evaluator
      
      # Creates an evaluator instance
      def initialize(ast, special_functions = nil)
        @ast = ast
        @special_functions = special_functions
      end
      
      def __undefined__(var_name, node)
        raise RuntimeError, "#{var_name} undefined"
      end
      
      def __no_such_operator_for_signature__(name, sign)
        signstr = sign.collect{|x| R::Domain.to_literal(x)}.join(' ')
        raise RuntimeError, "No such operator (#{name} #{signstr})"
      end
      
      def __no_such_operator_for_args__(name, args)
        signature = args.collect{|x| R::Alpha::domain_of(x)}
        __no_such_operator_for_signature__(name, signature)
      end
      
      # Checks if a special function exists
      def has_special_function?(func)
        false
      end
      
      # Finds an operator by name and specific arguments
      def find_operator_by_args(name, args)
        args.each{|arg|
          dom = R::Alpha::domain_of(arg)
          op  = dom.find_operator_by_args(name, args)
          return op unless op.nil?
        }
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
            else
              __undefined__(var_name, node)
            end
            
          # Resolving a true literal
          when :_
            node.literal
            
          # Resolving other functions
          else
            if sp = has_special_function?(func)
            else
              # evaluate the children and come back
              args = node.children.collect{|c| evaluate(context, c)}
              find_operator_by_args(func, args).call(args)
            end
        end
      end
      
    end # class Evaluator
  end # module R
end # module SByC