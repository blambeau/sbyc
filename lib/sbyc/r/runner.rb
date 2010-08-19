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
      end
      
      # Makes a definition
      def def(name, what)
        @definitions[name] = what
        if what.kind_of?(::Class) and what.respond_to?(:sbyc_domain)
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
      
      # Collects evaluations on a node
      def collect(node, binding)
        node.children.collect{|child| evaluate(child, binding)}
      end
      
      # Applies major coercions 
      def coerce(arg, clazz, binding)
        case arg
          when clazz
            arg
          when ::CodeTree::AstNode
            coerce(evaluate(arg, binding), clazz, binding)
          else
            if clazz.nil?
              arg
            else
              __undefined_operator__!(clazz.name.to_sym, [ arg ])
            end
        end
      end
      
      # Makes an evaluation
      def evaluate(node, binding = {})
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
      end
      
      # Making a self call
      def self_call(function, args, binding)
        case function
          when :self
            self
            
          when :def
            __args_have_arity__!(:def, args, 2)
            name = coerce(args[0], ::Symbol, binding)
            what = args[1]
            if what.kind_of?(::CodeTree::AstNode)
              what = evaluate(what, binding) 
            end
            self.def(name, what)
            
          when :fed
            __args_have_arity__!(:fed, args, 1)
            name = coerce(args[0], ::Symbol, binding)
            self.fed(name)
            
          when :'ruby-send'
            method   = coerce(args.shift, ::Symbol, binding)
            receiver = coerce(args.shift, nil, binding)
            args     = args.collect{|arg| coerce(arg, nil, binding)}
            receiver.send(method, *args)
            
          else
            __undefined_operator__!(function, args)
        end
      end
      
    end # class Runner
  end # module R
end # module SByC