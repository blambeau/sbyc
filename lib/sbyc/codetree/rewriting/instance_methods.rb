module CodeTree
  module Rewriting
    class Rewriter
      module InstanceMethods
    
        # Installed rules
        attr_reader :rules
    
        # The scope
        attr_reader :scope
    
        # Creates a Rewriter instance
        def initialize
          @rules = []
          yield(self) if block_given?
        end
    
        def ANY()    Rewriter::Match::ANY;    end
        def BRANCH() Rewriter::Match::BRANCH; end
        def LEAF()   Rewriter::Match::LEAF;   end

        # Adds a rule to the engine
        def rule(match, &block)
          @rules << Rewriter::Match.coerce(match, block)
        end
    
        # Rewrites some code
        def rewrite(code = nil, scope = nil, &block)
          @stack = []
          @scope = block ? code : scope
          apply(CodeTree.coerce(block || code))
        ensure 
          @stack = nil
          @scope = nil
        end
    
        # Returns the current context node, being the top node on the stack
        def context_node 
          @stack.last
        end
    
        # Applies rules on a node      
        def apply(*args)
          case node = apply_args_conventions(*args)
            when CodeTree::AstNode
              apply_on_node(node)
            when Array
              node.collect{|c| c.kind_of?(CodeTree::AstNode) ? apply_on_node(c) : c}
            else
              node
          end
        end
    
        # Applies on a single node
        def apply_on_node(node)
          raise ArgumentError, "Node expected, #{node.inspect} received" unless node.kind_of?(CodeTree::AstNode)
          @stack.push(node)
          rule = @rules.find{|r| r === node}
          result = (rule ? rule.apply(self, node) : nil)
          @stack.pop
          result
        end
    
        # Produces a node by copying another one
        def node(function, *children)
          CodeTree::AstNode.coerce([function, children.flatten])
        end
    
        # 
        # Applies conventions announced by the _apply_ method.
        #
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
    
      end # module InstanceMethods
      include InstanceMethods
    end # class Rewriter
  end # module Rewriting
end # module CodeTree
