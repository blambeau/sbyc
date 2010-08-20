class SByC::R::DomainGenerator::Builtin
  module HeadingDomain
    module ClassMethods
    
      def exemplars
        [ "(Heading)",
          "(Heading :name String)"].collect{|src|
          system.evaluate(system.parse(src))
        }
      end
    
      def is_value?(value)
        value.class == self
      end

      def parse_literal(str)
        if str =~ /^\(Heading /
          begin
            x = R::evaluate({}, str)
            if is_value?(x)
              x
            else
              __not_a_literal__!(self, str)
            end
          rescue CodeTree::ParseError
            __not_a_literal__!(self, str)
          end
        else
          __not_a_literal__!(self, str)
        end
      end

      def to_literal(value)
        value.to_s
      end
      
      def coerce(x)
        if is_value?(x)
          x
        elsif x.kind_of?(::Array)
          self.new(::Hash[*x.flatten])
        else
          super
        end
      end
    
      def call_signature(runner, args, binding)
        if args.size == 1
          [ [ ::Array ] ]
        elsif args.size % 2 == 0
          name, domain = runner.fed(:Symbol), runner.fed(:Domain)
          Array.new(args.size).fill{|index| index%2 == 0 ? [ symbol ] : [ domain ]}
        else
          call_error(runner, args, binding)
        end
      end
    
      def to_names_and_domains(runner, args, binding, &error_handler)
        names, domains = [], []
        args.each_slice(2){|name, type|
          names   << runner.ensure_arg(name, [ runner.fed(:Symbol) ], binding, &error_handler)
          domains << runner.ensure_arg(type, [ runner.fed(:Domain) ], binding, &error_handler)
        }
        [names, domains]
      end
    
      def sbyc_call(runner, args, binding)
        error_handler = lambda{ __selector_invocation_error__!(self, args) }
        if args.size == 1
          args = runner.ensure_arg(args.first, [ ::Array ], binding, &error_handler)
          self.new(*to_names_and_domains(runner, args, binding, &error_handler))
        else
          self.new(*to_names_and_domains(runner, args, binding, &error_handler))
        end
      end
    
    end
    module InstanceMethods
      
      # Names
      attr_reader :names
      
      # Domains
      attr_reader :domains
      
      # Creates a heading instance
      def initialize(names, domains)
        @names, @domains = names, domains
      end
      
      def sbyc_domain
        self.class
      end
      
      def to_s
        buffer, first = "(Heading ", true
        names.zip(domains).each{|k,v|
          buffer << ", " unless first 
          buffer << k.inspect << " " << v.sbyc_domain.to_literal(v)
          first = false
        }
        buffer << ")"
        buffer
      end
      alias :inspect :to_s
      
      def domain_of(name, default = nil)
        res = (hash[name] || default)
        if res.nil?
          self.class.__nil_error__("No such heading attribute #{name}", caller)
        else
          res
        end
      end
      
      def to_call_signature(runner, args, binding)
        domains.collect{|c| [ c ]}
      end
      
      def to_binding(runner, args, binding)
        args = runner.ensure_args(args, domains.collect{|c| [c]}, binding){
          runner.__signature_mistmatch__!(self, args)
        }
        b = {}
        names.zip(args).each{|name, arg| b[name] = arg}
        b
      end
      
      def to_hash
        Hash[*names.zip(domains).flatten]
      end
      
      def ==(other)
        other.kind_of?(self.class) && to_hash == other.to_hash
      end
      
    end
  end # module HeadingDomain
end # class SByC::R::DomainGenerator::Builtin