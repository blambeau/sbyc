class SByC::R::DomainGenerator::Builtin
  module HeadingDomain
    module ClassMethods
    
      def selector_signature
        @selector_signature ||= SByC::R::Operator::Signature::paired(SByC::R::Symbol, SByC::R::Domain)
      end
 
      def exemplars
        [ self.new(:name => R::String, :age => R::Integer) ]
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
        elsif x.kind_of?(::Hash)
          if x.keys.all?{|k| k.kind_of?(::Symbol)} &&
             x.values.all?{|v| v.kind_of?(::Class)}
            self.new(x)
          else
            super
          end
        else
          super
        end
      end
    
    end
    module InstanceMethods
      
      # Used hash
      attr_reader :hash
      
      # Creates a heading instance
      def initialize(hash)
        raise ArgumentError, "Hash expected git #{hash.inspect}" unless hash.kind_of?(::Hash)
        @hash = hash
      end
      
      def to_s
        buffer, first = "(Heading ", true
        hash.each_pair{|k,v|
          buffer << ", " unless first 
          buffer << k.inspect << " " << v.sbyc_domain.to_literal(v)
          first = false
        }
        buffer << ")"
        buffer
      end
      
      # Returns the domain of a given attribute 
      def domain_of(name, default = nil)
        res = (hash[name] || default)
        if res.nil?
          self.class.__nil_error__("No such heading attribute #{name}", caller)
        else
          res
        end
      end
      
      def ==(other)
        other.kind_of?(self.class) and other.hash == self.hash
      end
      
    end
  end # module HeadingDomain
end # class SByC::R::DomainGenerator::Builtin