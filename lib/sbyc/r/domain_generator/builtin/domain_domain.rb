class SByC::R::DomainGenerator::Builtin
  module DomainDomain
    
    def exemplars
      [ system.fed(:Alpha), system.fed(:Domain), system.fed(:Boolean) ]
    end
    
    def is_value?(value)
      value.respond_to?(:sbyc_domain) and value.sbyc_domain == self
    end
    
    def decode_domain_generation(str)
      R::parse(str, :parse_method => :parse_domain_generation_literal).visit{|node, collected|
        case f = node.function
          when :'_'
            node.literal
          when :fed
            system.fed(collected[0])
          else
            system.fed(f).sbyc_call(system, collected, {})
        end
      }
    rescue => ex
      __not_a_literal__!(self, str)
    end

    def parse_literal(str)
      if str.to_s[-1, 1] == ">"
        decode_domain_generation(str)
      elsif str.kind_of?(::String) && !str.empty?
        got = system.fed(str.to_sym)
        if got.nil?
          __not_a_literal__!(self, str)
        else
          got
        end
      else
        found = __find_ruby_module__(str, SByC::R)
        found = __find_ruby_module__(str) unless found
        if found and is_value?(found) 
          found
        else
          __not_a_literal__!(self, str)
        end
      end
    end

    def to_literal(value)
      name = value.domain_name.to_s
      (name =~ /^SByC::R::(.*)$/) ? $1 : name
    end

    RUBY_TO_R = {
      'Fixnum'     => :Integer,
      'Bignum'     => :Integer,
      'FalseClass' => :Boolean,
      'TrueClass'  => :Boolean,
      'Array'      => :Array
    }
    def coerce(x)
      if is_value?(x)
        return x 
      elsif x.kind_of?(::Class)
        parse_literal(RUBY_TO_R[x.name.to_s] || x.name)
      elsif x.kind_of?(::String)
        parse_literal(RUBY_TO_R[x] || x)
      else 
        super
      end
    end
      
    def call_signature
      @call_signature ||= [ [::Class, ::String, ::Symbol] ]
    end
    
    def sbyc_call(runner, args, binding)
      args = runner.ensure_args(args, call_signature, binding){
        runner.__selector_invocation_error__!(self, args)
      }
      case f = args.first
        when ::Class
          if f.respond_to?(:sbyc_domain) && f.sbyc_domain == runner.fed(:Domain)
            f
          else
            sbyc_call(runner, [ RUBY_TO_R[x.name.to_s] || x.name ], binding)
          end
        when ::String
          sbyc_call(runner, [ f.to_sym ], binding)
        when ::Symbol
          sbyc_call(runner, [ runner.fed(f) ], binding)
        else
          runner.__selector_invocation_error__!(self, args)
      end
    end
    
  end # module DomainDomain
end # class SByC::R::DomainGenerator::Builtin