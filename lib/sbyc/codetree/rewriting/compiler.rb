module SByC
  module CodeTree
    module Rewriting
      class Rewriter
        module Compiler
    
          # Compiles an Ast to a Rewriter instance
          def compile(ast)
            compiled = Rewriter.new
            Rewriter.new{|r|
              r.rule(:rewrite){|r, node, *children| 
                r.apply(children)
              }
              r.rule(:upon){|r, upon, upon_match, upon_rule|
                matcher = CodeTree::matcher(upon_match)
                upon_expr = CodeTree::expr(upon_rule)
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
    end # module Rewriting
  end # module CodeTree
end # module SByC