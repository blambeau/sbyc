module SByC
  class Rewriter
    module ClassMethods
      
      # Compiles a rewriter
      def compile(code = nil, &block)
        ::SByC::Rewriter::Compiler::compile(code || block)
      end
      
    end # module ClassMethods
    extend ClassMethods
  end # class Rewriter
end # module SByC
