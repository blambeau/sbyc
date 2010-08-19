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
      args = runner.ensure_args(args, [ [::TrueClass, ::FalseClass, ::String] ], binding){
        runner.__selector_invocation_error__!(self, args)
      }
      case f = args.first
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
