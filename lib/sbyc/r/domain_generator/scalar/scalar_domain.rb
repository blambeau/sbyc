class SByC::R::DomainGenerator::Scalar
  module ScalarDomain
    module ClassMethods
      
      attr_accessor :domain_name
      attr_accessor :heading
    
      def exemplars
        [ self.new(:name => "blambeau", :age => 30) ]
      end
    
      def is_value?(value)
        value.class == self
      end

      def parse_literal(str)
        if str =~ /^\(#{domain_name} /
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
        elsif x.kind_of?(Hash)
          self.new(x)
        elsif x.kind_of?(String)
          parse_literal(x)
        else
          super
        end
      end
      
    end
    module InstanceMethods
      
      # Used hash
      attr_reader :hash
      
      # Creates a scalar domain instance
      def initialize(hash)
        @hash = hash
      end
      
      def to_s
        hash.each_pair{|k,v|
          buffer << ", " unless first 
          buffer << k.inspect << " " << self.class.heading.domain_of(k).to_literal(v)
          first = false
        }
        buffer << ")"
        buffer
      end
      
      def ==(other)
        other.kind_of?(self.class) and other.hash == self.hash
      end
      
    end
  end # module ScalarDomain
end # class SByC::R::DomainGenerator::Builtin