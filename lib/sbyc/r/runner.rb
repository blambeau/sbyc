module SByC
  module R
    class Runner
      include R::Robustness
      
      # Creates a runner instance
      def initialize
        @definitions = {}
        __install__
      end
      
      # Installs the runner
      def __install__
        self.def(:BuiltinDomain, R::DomainGenerator::Builtin.new(self))
        self.def(:ArrayDomain,   R::DomainGenerator::Array.new(self))
      end
      
      def looks_a_domain?(d)
        d.kind_of?(::Class) && d.respond_to?(:sbyc_domain)
      end
      
      # Makes a definition
      def def(name, what)
        @definitions[name] = what
        if looks_a_domain?(what)
          what.instance_eval{ @sbyc_name = name }
        end
        what
      end
      
      # Gets a definition
      def fed(name)
        @definitions[name]
      end
      
      # Checks if a definition is known
      def knows?(name)
        @definitions.key?(name)
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
              if binding.has_key?(var_name)
                binding[var_name]
              elsif knows?(var_name)
                fed(var_name)
              else
                self_call(var_name, [], binding)
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
                self_call(f, node.children.dup, binding)
              end
          end
        else
          node
        end
      end
      
      # Ensures that a given argument is of specified accepted domains
      def ensure_arg(arg, accepted_domains, binding, &error_handler)
        if accepted_domains.include?(arg.class)
          arg
        elsif arg.kind_of?(CodeTree::AstNode)
          ensure_arg(evaluate(arg, binding), accepted_domains, binding, &error_handler)
        elsif accepted_domains.empty?
          arg
        elsif accepted_domains.size == 1
          requested_domain = accepted_domains.first
          if looks_a_domain?(requested_domain)
            requested_domain.sbyc_call(self, [ arg ], binding)
          else
            error_handler.call
          end
        else
          error_handler.call
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
      
      # Making a self call
      def self_call(function, args, binding)
        error_handler = lambda{ __signature_mistmatch__!(function, args) }
        case function
          when :self
            self
            
          when :def
            name, value = ensure_args(args, [ [::Symbol], [] ], binding, &error_handler)
            self.def(name, value)
            
          when :fed
            name, = ensure_args(args, [ [ ::Symbol ] ], binding, &error_handler)
            self.fed(name)
            
          when :'ruby-send'
            method, receiver = ensure_args(args[0..1], [ [::Symbol ], [ ] ], binding, &error_handler)
            call_args = args[2..-1].collect{|arg| ensure_arg(arg, [], binding)}
            receiver.send(method, *call_args)
            
          else
            __undefined_operator__!(function, args)
        end
      end
      
    end # class Runner
  end # module R
end # module SByC