module SByC
  module Typing
    module R
      module System
      
        #######################################################################
        ### About installation
        #######################################################################
        def install(&block)
          block.call(self)
        end
      
        #######################################################################
        ### About domains
        #######################################################################
      
        # Returns the domains
        def domains
          [ R::Domain ] + R::Domain.prinstine_domains
        end
      
        # Ensures a domain on x
        def coerce_domain!(x)
          R::Domain::coerce(x)
        end
        
        # Does a given value looks a domain
        def looks_a_domain?(x)
          x.kind_of?(Class) and x.ancestors.include?(R::Domain)
        end
        
        # Does a given value looks a prinstine domain
        def looks_a_prinstine_domain?(x)
          looks_a_domain?(x) and !(x == R::Domain)
        end
        
        # Returns the domain of a value
        def domain_of(value)
          if value.respond_to?(:sbyc_domain)
            return value.sbyc_domain
          else
            coerce_domain!(value.class)
          end
        end
        alias :type_of :domain_of
      
        #######################################################################
        ### About literals
        #######################################################################
        
        # Converts a value to a literal
        def to_literal(value)
          domain_of(value).to_literal(value)
        end
      
        # Parses a literal
        def parse_literal(literal)
          domains.each{|d| 
            begin
              return d.parse_literal(literal)
            rescue SByC::TypeError
            end
          }
          __not_a_literal__!(self, literal)
        end
        
        #######################################################################
        ### About coercions
        #######################################################################
        
        # Coerces a value
        def coerce(value, domain = nil)
          if domain.nil?
            coerce_domain!(value.class).coerce(value)
          else
            coerce_domain!(domain).coerce(value)
          end
        end
      
        #######################################################################
        ### About operators
        #######################################################################
        
        # Returns an operator for a given name and signature
        def find_operator_by_signature(name, signature)
          signature[0].find_operator_by_signature(name, signature)
        end
        
        # Returns an operator for a given name and args
        def find_operator_by_args(name, args)
          find_operator_by_signature(name, args.collect{|arg| domain_of(arg)})
        end
        
        #######################################################################
        ### About type checking
        #######################################################################
        
        # Returns the of an expression
        def type_check_by_heading(heading, expr = nil, &block)
          CodeTree::coerce(expr || block).visit{|node, collected|
            case f = node.function
              when :'?'
                var_name = node.literal
                if heading.key?(node.literal)
                  coerce_domain!(heading[node.literal])
                else
                  __type_check_error__!("No such variable #{var_name}")
                end
              when :'_'
                domain_of(node.literal)
              else
                op = find_operator_by_signature(f, collected)
                if op
                  op.result_domain
                else
                  types_str = collected.collect{|x| x.short_name}.join(', ')
                  __type_check_error__!("No such operator #{f}(#{types_str})")
                end
            end
          }
        end
        alias :result_domain_by_heading :type_check_by_heading

        # Returns the of an expression
        def type_check_by_args(args, expr = nil, &block)
          heading = {}
          args.each_pair{|name, value| heading[name] = domain_of(value)}
          result_domain_by_heading(heading, expr, &block)
        end
        alias :type_check :type_check_by_args
        alias :result_domain_by_args :type_check_by_args
        
        #######################################################################
        ### About execution
        #######################################################################
        
        # Evaluates an expression inside a given context
        def evaluate(context = {}, expr = nil, &block)
          ast = CodeTree::coerce(expr || block)
          type_check_by_args(context, ast)
          result = ast.visit{|node, collected|
            case f = node.function
              when :'?'
                context[node.literal]
              when :'_'
                node.literal
              else
                sign = collected.collect{|v| domain_of(v)}
                op = find_operator_by_signature(f, sign)
                op.call(collected)
            end
          }
          result
        end
        
      end # module System
    end # module R
  end # module Typing
end # module SByC