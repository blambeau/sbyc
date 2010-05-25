module CodeTree
  module Producing
    class Producer
      
      # Rules kepts by node function
      attr_reader :rules
      
      # Extension options.
      attr_reader :extension_options
      
      # Creates a producer instance
      def initialize(default_rules = true)
        @rules = {}
        @extension_options = {}
        if default_rules
          rule(:_) {|r,node| node.literal}
          rule("*"){|r,node| r.apply(node.children)}
        end
        yield(self) if block_given?
      end
      
      # Adds an extension module
      def add_extension(mod, options = {})
        self.extend(mod)
        options = mod.const_get(:DEFAULT_OPTIONS).merge(options) if mod.const_defined?(:DEFAULT_OPTIONS)
        extension_options[mod] = options
        self
      end
      
      # Adds a rule
      def rule(function_name, &block)
        rules[function_name] = block
      end
      
      # Applies on some arguments
      def apply(*args)
        case args = apply_args_conventions(*args)
          when CodeTree::AstNode
            apply_on_node(args)
          when Array
            args.collect{|c| apply(c)}
          else
            args
        end
      end
      
      # Applies on a given node
      def apply_on_node(node)
        func = node.function
        if rules.key?(func)
          @rules[func].call(self, node)
        elsif rules.key?("*")
          @rules["*"].call(self, node)
        else
          nil
        end
      end
      
      # Applies arument conventions allowed by _apply_
      def apply_args_conventions(*args)
        if args.size == 1 and args[0].kind_of?(CodeTree::AstNode)
          args[0]
        elsif args.size > 1 and args[0].kind_of?(Symbol)
          function = args.shift
          children = args.collect{|c| apply_args_conventions(c)}.flatten
          CodeTree::AstNode.coerce([function, children])
        elsif args.all?{|a| a.kind_of?(CodeTree::AstNode)}
          args
        elsif args.size == 1
          args[0]
        else
          raise ArgumentError, "Unable to apply on #{args.inspect} (#{args.size})", caller
        end
      end
      
      private :apply_on_node
      private :apply_args_conventions
    end # class Producer
  end # module Producing
end # module CodeTree