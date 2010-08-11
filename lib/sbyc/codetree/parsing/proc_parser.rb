module SByC
  module CodeTree
    module Parsing
      class ProcParser
        #
        # Collector when :multiline option is set to true.
        #
        class Collector

          # Which nodes are kept?
          attr_reader :kept

          # Creates a collector instance
          def initialize
            @kept = []
          end

          # Callback when a new Expr is created
          def built(who, children)
            @kept << who
            children.each{|c| @kept.delete_if{|k| k.__id__ == c.__id__}}
          end
      
          # Returns expressions as an array of AstNodes
          def to_a
            kept.collect{|c| c.__to_functional_code}
          end

        end # class Collector
    
        # An expression
        class Expr
      
          # Methods that we keep
          KEPT_METHODS = [ "__send__", "__id__", "instance_eval", "instance_exec", "initialize", "object_id", 
                           "singleton_method_added", "singleton_method_undefined", "method_missing",
                           "__evaluate__", "coerce", "kind_of?"]

          class << self
            def __clean_scope__
              # Removes all methods that are not needed to the class
              (instance_methods + private_instance_methods).each do |m|
                m_to_s = m.to_s
                undef_method(m_to_s.to_sym) unless ('__' == m_to_s[0..1]) or KEPT_METHODS.include?(m_to_s)
              end
            end
          end
    
          # Creates an expression instance
          def initialize(name, children, collector)
            class << self; __clean_scope__; end
            @name, @children, @collector = name, children, collector
            if @collector and @name
              @collector.built(self, children)
            end
          end
      
          # Returns the associated functional code
          def __to_functional_code
            children = (@children || []).collect{|c|
              c.kind_of?(Expr) ? c.__to_functional_code : AstNode.coerce(c)
            }
            CodeTree::AstNode.coerce([@name, children])
          end
          alias :inspect :__to_functional_code
      
          # Called when a method is missing
          def method_missing(name, *args)
            if @name.nil?
              if name == :[]
                Expr.new(:'?', args, @collector)
              elsif args.empty?
                Expr.new(:'?', [name], @collector)
              else
                Expr.new(name, args, @collector)
              end
            else
              args.unshift(self)
              Expr.new(name, args, @collector)
            end
          end
      
          def coerce(other)
            [self, other]
          end

        end # class Expr
      
        # Calls a proc object
        def self.call_proc(block, collector = nil)
          case block.arity
            when -1, 0
              expr = Expr.new(nil, nil, collector)
              if RUBY_VERSION >= "1.9.2"
                expr.instance_exec(&block)
              else
                expr.instance_eval(&block)
              end
            when 1
              block.call(Expr.new(nil, nil, collector))
            else
              raise ArgumentError, "Unexpected block arity #{block.arity}"
          end
        end
    
        # Parses a Proc object
        def self.parse_proc(block, options = {})
          collector = options[:multiline] ? Collector.new : nil
          e = call_proc(block, collector)
          return collector.to_a if collector
          case e
            when Expr
              e.__to_functional_code
            else
              CodeTree::AstNode.coerce(e)
          end
        end
    
        # Parses a block
        def self.parse(code = nil, options = {}, &block)
          block = code || block
          case block
            when Proc
              parse_proc(block, options)
            when AstNode
              block
            when String
              parse(Kernel.eval("proc{ #{block} }"), options)
            else
              raise ArgumentError, "Unable to parse #{block}"
          end
        end
    
      end # class ProcParser
    end # module Parsing
  end # module CodeTree
end # module SByC