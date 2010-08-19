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
    
    def call_signature(runner)
      @call_signature ||= [ [::TrueClass, ::FalseClass, ::String] ]
    end
    
    def coerce(runner, args, binding)
      case f = args.first
        when ::TrueClass, ::FalseClass
          f
        when 'true'
          true
        when 'false'
          false
        else
          call_error(runner, args, binding)
      end
    end
    
  end # module BooleanDomain
end # class SByC::R::DomainGenerator::Builtin
