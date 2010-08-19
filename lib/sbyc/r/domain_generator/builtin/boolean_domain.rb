class SByC::R::DomainGenerator::Builtin
  module BooleanDomain
    
    def exemplars
      [ true, false ]
    end
    
    def is_value?(value)
      value == true || value == false
    end

    def parse_literal(str)
      str = str.to_s.strip
      if str == 'true'
        return true
      elsif str == 'false'
        return false
      else
        __not_a_literal__!(self, str)
      end
    end

    def to_literal(value)
      value == true ? "true" : "false"
    end
    
    def sbyc_call(runner, args, binding)
      runner.__selector_invocation_error__!(self, args) unless args.size == 1
      case f = args.first
        when CodeTree::AstNode
          sbyc_call(runner, [ runner.evaluate(f, binding) ], binding)
        when ::TrueClass, ::FalseClass
          f
        when 'true'
          true
        when 'false'
          false
        else
          runner.__selector_invocation_error__!(self, args)
      end
    end
    
  end # module BooleanDomain
end # class SByC::R::DomainGenerator::Builtin
