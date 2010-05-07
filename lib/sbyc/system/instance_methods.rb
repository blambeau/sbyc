require 'sbyc/system/class_methods'
require 'sbyc/system/signature'
require 'sbyc/system/operator'
module SByC
  class System
    module InstanceMethods
  
      # Defined operators
      attr_reader :operators
  
      # Creates a type system instance
      def initialize
        @operators = Hash.new{|h,k| h[k] = []}
        yield(self) if block_given?
      end
  
      # Adds an operator
      def add_operator(name, signature, code)
        signature = Signature.coerce(signature)
        [name].flatten.each do |n|
          operators[n] << Operator.new(n, signature, code)
        end
      end
      alias :<< :add_operator
  
      # Find the op
      def find_operator(name, arg_types)
        operators[name].find{|op| op.signature.matches?(arg_types)}
      end
    
      # Parses some code
      def parse(code = nil, &block)
        ::SByC::CodeTree.coerce(code || block)
      end
    
      # Applies type checking to a code tree
      def type_check(code = nil, &block)
        op = ::SByC::CodeTree.coerce(code || block).type_check(self)
        op.return_type
      end
    
      # Converts a code tree to some ruby code
      def to_ruby_code(code = nil, do_type_check = true, &block)
        code_tree = ::SByC::CodeTree.coerce(code || block)
        type_check(code_tree) if do_type_check
        code_tree.to_ruby_code(self)
      end
    
      # Compile some code and returns a lambda object that can be called.
      def compile(code = nil, do_type_check = true, &block)
        code = to_ruby_code(code, do_type_check, &block)
        Kernel.eval "Kernel::lambda {|*args| #{code}}"
      end
      
    end # module InstanceMethods
    include InstanceMethods
  end # class System
end # module SByC