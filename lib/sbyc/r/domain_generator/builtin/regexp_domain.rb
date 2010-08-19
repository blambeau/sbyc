class SByC::R::DomainGenerator::Builtin
  module RegexpDomain
    
    def exemplars
      [ /a-z/, /^$/, /\s*/, /[a-z]{15}/ ]
    end
    
    def is_value?(value)
      value.kind_of?(::Regexp)
    end

    def parse_literal(str)
      str = str.to_s.strip
      if str =~ /^\/(.*)\/$/
        begin
          ::Regexp::compile($1)
        rescue Exception => ex
          __not_a_literal__!(self, str)
        end
      else
        __not_a_literal__!(self, str)
      end
    end

    def to_literal(value)
      value.inspect
    end
    
    def coerce(x)
      if is_value?(x)
        x
      elsif x.kind_of?(::String)
        begin
          ::Regexp::compile(x)
        rescue
          parse_literal(x)
        end
      else
        super
      end
    end
    
    def sbyc_call(runner, args, binding)
      args = runner.ensure_args(args, [ [::Regexp, ::String] ], binding){
        runner.__selector_invocation_error__!(self, args)
      }
      case f = args.first
        when ::Regexp
          f
        when ::String
          begin
            ::Regexp::compile(f)
          rescue
            runner.__selector_invocation_error__!(self, args)
          end
        else
          runner.__selector_invocation_error__!(self, args)
      end
    end
    
  end # module RegexpDomain
end # class SByC::R::DomainGenerator::Builtin