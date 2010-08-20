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
            system.make_call(system.fed(f), collected, {})
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
      value.domain_name.to_s
    end
      
    def call_signature(runner, args, binding)
      @call_signature ||= [ [::Class, ::String, ::Symbol] ]
    end
    
    RUBY_TO_R = {
      'Fixnum'     => :Integer,
      'Bignum'     => :Integer,
      'FalseClass' => :Boolean,
      'TrueClass'  => :Boolean,
      'Array'      => :Array,
      'SByC::CodeTree::AstNode' => :Ast
    }
    def coerce(runner, args, binding)
      case f = args.first
        when ::Class
          if f.respond_to?(:sbyc_domain) && f.sbyc_domain == runner.fed(:Domain)
            f
          else
            coerce(runner, [ RUBY_TO_R[f.name.to_s] || f.name ], binding)
          end
        when ::String
          coerce(runner, [ f.to_sym ], binding)
        when ::Symbol
          coerce(runner, [ runner.fed(f) ], binding)
        else
          call_error(runner, args, binding)
      end
    end
    
  end # module DomainDomain
end # class SByC::R::DomainGenerator::Builtin