require 'sbyc/r/system/core'
module SByC
  module R
    class Runner
      include R::Robustness
      
      # Opened namespaces
      attr_reader :opened_namespaces
      
      # Creates a runner instance
      def initialize
        @opened_namespaces = [ R::System::Core.new(self) ]
      end

      # Pushes a namespace
      def push_namespace(namespace)
        opened_namespaces.push(namespace)
      end
      
      # Pops the last namespace
      def pop_namespace
        opened_namespaces.pop
      end
      
      # Peeks the namespace at top
      def peek_namespace
        opened_namespaces.last
      end
      
      def each_global(&block)
        peek_namespace.each_pair(&block)
      end
      
      def looks_a_domain?(d)
        d.kind_of?(::Class) && d.respond_to?(:sbyc_domain)
      end
      
      # Makes a definition
      def def(name, what)
        peek_namespace.def(name, what)
      end
      
      # Gets a definition
      def fed(name)
        opened_namespaces.reverse.each{|n|
          return n.fed(name) if n.knows?(name)
        }
        nil
      end
      
      # Checks if a definition is known
      def knows?(name)
        opened_namespaces.any?{|n| n.knows?(name)}
      end
      
      # Makes an evaluation
      def evaluate(node, binding = {})
        if node.kind_of?(CodeTree::AstNode)
          case f = node.function

            # Resolving a true literal
            when :_
              node.literal
          
            # Resolving a variable name
            when :'?'  
              var_name = node.literal
              if var_name == :self
                self
              elsif binding.has_key?(var_name)
                binding[var_name]
              elsif knows?(var_name)
                fed(var_name)
              else
                __undefined_operator__!(var_name, [])
              end
            
            # Making a private call
            else
              if knows?(f)
                got = fed(f)
                if got.respond_to?(:sbyc_call)
                  got.sbyc_call(self, node.children.dup, binding)
                else
                  __not_a_callable_error__!(got)
                end
              else
                __undefined_operator__!(f, node.children)
              end
          end
        else
          node
        end
      end
      
      # Ensures that a given argument is of specified accepted domains
      def ensure_arg(arg, accepted_domains, binding, &error_handler)
        result = if accepted_domains.include?(arg.class)
          arg
        elsif arg.kind_of?(CodeTree::AstNode)
          ensure_arg(evaluate(arg, binding), accepted_domains, binding, &error_handler)
        elsif accepted_domains.empty?
          arg
        elsif accepted_domains.size == 1
          requested_domain = accepted_domains.first
          if looks_a_domain?(requested_domain)
            if requested_domain.is_value?(arg)
              arg
            else
              requested_domain.sbyc_call(self, [ arg ], binding)
            end
          else
            error_handler.call
          end
        else
          error_handler.call
        end
        if result.nil?
          raise "Unexpected nil value when converting #{arg.inspect} with #{accepted_domains.inspect}"
        else
          result
        end
      end
      
      # Ensures that some arguments are of specific domain
      def ensure_args(args, accepted_domains, binding, &error_handler)
        unless args.size == accepted_domains.size
          error_handler.call 
        else
          args.zip(accepted_domains).collect{|arg, domains|
            ensure_arg(arg, domains, binding, &error_handler)
          }
        end
      end
            
    end # class Runner
  end # module R
end # module SByC