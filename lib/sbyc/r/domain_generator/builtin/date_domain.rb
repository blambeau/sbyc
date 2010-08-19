class SByC::R::DomainGenerator::Builtin
  module DateDomain
    
    # Returns exemplars
    def exemplars
      [ ::Date.today ]
    end
    
    # Returns true if a given value belongs to this domain,
    # false otherwise
    def is_value?(value)
      value.kind_of?(::Date)
    end

    # Parses a literal from the domain and returns
    # a value
    def parse_literal(str)
      str = str.to_s.strip
      if str =~ /^\(Date (.*)\)$/
        ::Date::parse($1)
      else
        __not_a_literal__!(self, str)
      end
    end

    # Converts a value to a literal
    def to_literal(value)
      "(Date #{value.to_s.inspect})"
    end
    
    # Coerces a string to a time
    def coerce(x)
      if is_value?(x)
        x
      elsif x.kind_of?(::String)
        begin 
          ::Date::parse(x)
        rescue 
          parse_literal(x)
        end
      else
        super
      end
    end
    
    def sbyc_call(runner, args, binding)
      runner.__selector_invocation_error__!(self, args) unless args.size == 1
      case f = args.first
        when CodeTree::AstNode
          sbyc_call(runner, [ runner.evaluate(f, binding) ], binding)
        when ::Date
          f
        when ::String
          begin 
            ::Date::parse(f)
          rescue => ex 
            runner.__selector_invocation_error__!(self, args)
          end
        else
          runner.__selector_invocation_error__!(self, args)
      end
    end
    
  end # module DateDomain
end # class SByC::R::DomainGenerator::Builtin