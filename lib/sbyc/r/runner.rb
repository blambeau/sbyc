require 'sbyc/r/system/core'
module SByC
  module R
    class Runner
      include R::Robustness
      
      # All loaded namespaces
      attr_reader :namespaces
      
      # Opened namespaces
      attr_reader :opened_namespaces
      
      # Creates a runner instance
      def initialize
        @namespaces = {:Core => R::System::Core.new(self)}
        @opened_namespaces = [ @namespaces[:Core] ]
        file_execute(File.expand_path('../system/core.elo', __FILE__))
        file_execute(File.expand_path('../system/macro.elo', __FILE__))
        file_execute(File.expand_path('../system/domain.elo', __FILE__))
        file_execute(File.expand_path('../system/boolean.elo', __FILE__))
        file_execute(File.expand_path('../system/numeric.elo', __FILE__))
        file_execute(File.expand_path('../system/string.elo', __FILE__))
        file_execute(File.expand_path('../system/array.elo', __FILE__))
      end
      
      ### About namespaces ####################################################

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
      
      # Yields a block ensuring that a given namespace is on top of 
      # the stack
      def with_namespace(name, create = true, &block)
        if namespaces.key?(name)
          n = namespaces[name]
          if block
            push_namespace(n)
            block.call(n)
            pop_namespace
          else
            push_namespace(n)
          end
        elsif create
          namespaces[name] = Namespace.new(self, name)
          with_namespace(name, false, &block)
        else
          __no_such_namespace__!(name)
        end
      end
      
      ### Namespace delegation ################################################

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
        opened_namespaces.any?{|n| 
          n.knows?(name)
        }
      end
      
      ### Parsing and execution
      
      # Parses some code and returns an Ast
      def parse(code, options = nil, &block)
        code = code || block
        if code.kind_of?(CodeTree::AstNode)
          code
        elsif code.kind_of?(Proc)
          CodeTree::parse(code, options)
        else
          R::Parser.new(code).parse(options || {})
        end
      end
      
      # Executes a whole file
      def file_execute(file)
        exprs = parse(File.read(file), {:multiline => true})
        result = nil
        exprs.each{|expr| result = evaluate(expr)}
        result
      end
      
      # Makes a call
      def make_call(callable, args, binding)
        callable = __assert_callable__!(callable)
        if callable.works_on_ast?
          callable.sbyc_call(self, args, binding)
        else
          args = args.collect{|arg| evaluate(arg, binding)}
          callable.sbyc_call(self, args, binding)
        end
      end
    
      # Makes an evaluation
      def evaluate(node, binding = {})
        unless node.kind_of?(CodeTree::AstNode)
          node
        else
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
                make_call(fed(f), node.children.dup, binding)
              else
                __undefined_operator__!(f, node.children)
              end
          end
        end
      end
      
      ### Tools
      
      def each_global(&block)
        peek_namespace.each_pair(&block)
      end
      
      def looks_a_domain?(d)
        d.kind_of?(::Class) && d.respond_to?(:sbyc_domain)
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
              make_call(requested_domain, [ arg ], binding)
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