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
    
    def call_signature(runner)
      @call_signature ||= [ [::Regexp, ::String] ]
    end
    
    def coerce(runner, args, binding)
      case f = args.first
        when ::Regexp
          f
        when ::String
          begin
            ::Regexp::compile(f)
          rescue
            call_error(runner, args, binding)
          end
        else
          call_error(runner, args, binding)
      end
    end
    
  end # module RegexpDomain
end # class SByC::R::DomainGenerator::Builtin