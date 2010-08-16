module SByC
  module R
    class Operator
      class Matcher
      
        #
        # Compiles expressions to matchers
        #
        # (plus (seq Symbol Alpha))
        #
        def self.compile(expr = nil, &block)
          ast = SByC::CodeTree::coerce(expr || block)
          ast.visit{|node, collected|
            case node.function
              when :_
                if (n = node.literal).nil?
                  EmptyMatcher.new
                else
                  SingleMatcher.new(node.literal)
                end
              when :seq
                SeqMatcher.new(collected)
              when :plus
                PlusMatcher.new(collected[0])
              when :star
                StarMatcher.new(collected[0])
              else
                raise "Unexpected expression #{node.function}"
            end
          }
        end
      
        def call_with_star?
          true
        end
      
        def domain_matches?(domains, requester = nil)
          !prepare_signature_for_type_checking(domains).nil?
        end

        def prepare_signature_for_type_checking(sign)
          x = eat_signature(sign)
          (x.nil? || !sign.empty?) ? nil : x
        end
        
        def args_matches?(args, requester = nil)
          !prepare_args_for_call(args).nil?
        end

        def prepare_args_for_call(args)
          x = eat_args(args)
          (x.nil? || !args.empty?) ? nil : x
        end
      
      end # class Matcher
    end # class Operator
  end # module R
end # module SByC
require 'sbyc/r/operator/matcher/empty_matcher'
require 'sbyc/r/operator/matcher/single_matcher'
require 'sbyc/r/operator/matcher/plus_matcher'
require 'sbyc/r/operator/matcher/star_matcher'
require 'sbyc/r/operator/matcher/seq_matcher'
