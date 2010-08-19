class SByC::R::DomainGenerator::Builtin
  module HeadingDomain
    module ClassMethods
    
      def selector_signature
        s = SByC::R::Operator::Signature
        @selector_signature ||= s::star(s::matcher(system::Symbol, system::Domain))
      end
 
      def exemplars
        [ self.new(:name => system::String, :age => system::Integer) ]
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
    
      def sbyc_call(runner, args, binding)
        error_handler = lambda{ __selector_invocation_error__!(self, args) }
        names, domains = [], []
        args.each_slice(2){|name, type|
          names   << runner.ensure_arg(name, [ runner.fed(:Symbol) ], binding, &error_handler)
          domains << runner.ensure_arg(type, [ runner.fed(:Domain) ], binding, &error_handler)
        }
        self.new(names, domains)
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
      
      def to_hash
        Hash[*names.zip(domains).flatten]
      end
      
      def ==(other)
        other.kind_of?(self.class) && to_hash == other.to_hash
      end
      
    end
  end # module HeadingDomain
end # class SByC::R::DomainGenerator::Builtin