class SByC::R::DomainGenerator::Builtin
  module AstDomain
    
    def exemplars
      [ system.parse('(hello "world")') ]
    end
    
    def is_value?(value)
      value.kind_of?(CodeTree::AstNode)
    end

    def parse_literal(str)
      __not_a_literal__!(self, str)
    end

    def to_literal(value)
      value.to_s
    end
    
    def call_signature(runner, args, binding)
      @call_signature ||= [ [ CodeTree::AstNode ] ]
    end
    
    def coerce(runner, args, binding)
      case f = args.first
        when CodeTree::AstNode
          f
        else
          call_error(runner, args, binding)
      end
    end
    
  end # module AstDomain
end # class SByC::R::DomainGenerator::Builtin
