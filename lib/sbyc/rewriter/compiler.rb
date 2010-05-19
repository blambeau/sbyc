module SByC
  class Rewriter
    module Compiler
      
      # Compiles an Ast to a Rewriter instance
      def compile(ast)
        compiled = ::SByC::Rewriter.new
        ::SByC::Rewriter.new{|r|
          r.rule(:rewrite){|r, node, *children| 
            r.apply(children)
          }
          r.rule(:upon){|r, upon, upon_match, upon_rule|
            matcher = ::SByC::CodeTree::matcher(upon_match)
            upon_expr = ::SByC::CodeTree::expr(upon_rule)
            r.scope.rule(matcher){|compiled, matched, *matched_children| 
              upon_expr.apply(compiled, (matcher =~ matched))
            }
          }
        }.rewrite(ast, compiled)
        compiled
      end
      module_function :compile
      
    end # module Compiler
  end # class Rewriter
end # module SByC
    