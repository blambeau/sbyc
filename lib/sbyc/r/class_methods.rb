module SByC
  module R
    module ClassMethods
    
      #######################################################################
      ### About literals
      #######################################################################
      
      # Converts a value to a literal
      def to_literal(value)
        R::Alpha::to_literal(value)
      end
    
      # Parses a literal
      def parse_literal(literal)
        R::Alpha.parse_literal(literal)
      end
      
      #######################################################################
      ### About coercions
      #######################################################################
      
      # Coerces a value
      def coerce(value, domain = nil)
        if domain.nil?
          R::Domain::coerce(value.class).coerce(value)
        else
          R::Domain::coerce(domain).coerce(value)
        end
      end
    
      #######################################################################
      ### About operators
      #######################################################################
      
      # Returns an operator for a given name and signature
      def find_operator_by_signature(name, signature)
        signature[0].find_operator(name, signature)
      end
      
      # Returns an operator for a given name and args
      def find_operator_by_args(name, args)
        find_operator_by_signature(name, args.collect{|arg| R::Alpha::domain_of(arg)})
      end
      
      #######################################################################
      ### About type checking
      #######################################################################
      
      # Returns the of an expression
      def type_check_by_heading(heading, expr = nil, &block)
        parse(expr || block).visit{|node, collected|
          case f = node.function
            when :'?'
              var_name = node.literal
              if heading.key?(node.literal)
                R::Domain::coerce(heading[node.literal])
              else
                __type_check_error__!("No such variable #{var_name}")
              end
            when :'_'
              R::Alpha::domain_of(node.literal)
            else
              op = find_operator_by_signature(f, collected)
              if op
                op.result_domain_by_heading(collected)
              else
                types_str = collected.collect{|x| R::Domain.to_literal(x)}.join(', ')
                __type_check_error__!("No such operator #{f}(#{types_str})")
              end
          end
        }
      end
      alias :result_domain_by_heading :type_check_by_heading

      # Returns the of an expression
      def type_check_by_args(args, expr = nil, &block)
        heading = {}
        args.each_pair{|name, value| heading[name] = R::Alpha::domain_of(value)}
        result_domain_by_heading(heading, expr, &block)
      end
      alias :type_check :type_check_by_args
      alias :result_domain_by_args :type_check_by_args
      
      #######################################################################
      ### About execution
      #######################################################################
      
      # Evaluates an expression inside a given context
      def evaluate(context = {}, expr = nil, &block)
        ast = parse(expr || block)
        type_check_by_args(context, ast)
        result = ast.visit{|node, collected|
          case f = node.function
            when :'?'
              context[node.literal]
            when :'_'
              node.literal
            else
              sign = collected.collect{|v| R::Alpha::domain_of(v)}
              op = find_operator_by_signature(f, sign)
              op.call(collected)
          end
        }
        result
      end
      
    end # module ClassMethods
  end # module R
end # module SByC