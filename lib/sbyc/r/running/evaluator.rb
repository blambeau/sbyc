module SByC
  module R
    class RuntimeError < StandardError; end
    class Evaluator
      
      # Creates an evaluator instance
      def initialize(ast, global_operators = SByC::R::GlobalOperators)
        @ast = ast
        @global_operators = global_operators
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
      def global_operator(func, args)
        @global_operators.find_operator_by_args(func, args)
      end
      
      # Finds an operator by name and specific arguments
      def find_operator_by_args(name, args)
        args.each{|arg|
          dom = R::Alpha::domain_of(arg)
          op  = dom.find_operator_by_args(name, args)
          return op unless op.nil?
        }
        op = global_operator(name, args)
        if op
          op
        else
          __no_such_operator_for_args__(name, args)
        end
      end
      
      # Lauches evaluation
      def evaluate(context = {}, node = @ast)
        case func = node.function
          
          # Resolving a variable name
          when :'?'
            var_name = node.literal
            if context.has_key?(var_name)
              context[var_name]
            elsif f = global_operator(var_name, [])
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