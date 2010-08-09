module SByC
  module R
    module RegexpDomain
      
      # Returns true if a given value belongs to this domain,
      # false otherwise
      def is_value?(value)
        value.kind_of?(::Regexp)
      end
  
      # Parses a literal from the domain and returns
      # a value
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
  
      # Converts a value to a literal
      def to_literal(value)
        value.inspect
      end
      
      # Coerces a regular expression from a string
      def str_coerce(str)
        ::Regexp::compile(str)
      end
      
    end # module RegexpDomain
    Regexp = R::WrapRubyDomain(:Regexp, ::Regexp, RegexpDomain)
  end # module R
end # module SByC