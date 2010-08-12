module SByC
  module R
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
      
    end # module RegexpDomain
  end # module R
end # module SByC