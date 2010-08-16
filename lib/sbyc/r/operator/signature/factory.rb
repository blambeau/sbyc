module SByC
  module R
    class Operator
      class Signature
        module Factory
          
          def matcher(*args)
            case args.size
              when 0
                Operator::EmptyMatcher.new
              when 1
                Operator::Matcher.coerce(args[0])
              else
                SeqMatcher.new(args.collect{|s| matcher(s)})
            end
          end
          
          def regular(*args, &block)
            if block 
              Signature.new(Matcher.compile(&block))
            else
              seq(*args)
            end
          end
        
          def s(*args)
            Signature.new(matcher(*args))
          end
          alias :seq :s
          alias :single :s
        
          def star(*args)
            Signature.new(StarMatcher.new(matcher(*args)))
          end
        
          def plus(*args)
            Signature.new(PlusMatcher.new(matcher(*args)))
          end
        
        end # module Factory
      end # class Signature
    end # class Operator
  end # module R
end # module SByC
