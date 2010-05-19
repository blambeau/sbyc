module SByC
  module CodeTree
    class Rewriter
      module ClassMethods
      
        # Compiles a rewriter
        def compile(code = nil, &block)
          Rewriter::Compiler::compile(code || block)
        end
      
      end # module ClassMethods
      extend ClassMethods
    end # class Rewriter
  end # module CodeTree
end # module SByC
