module SByC
  module R
    module TimeDomain
      
      def exemplars
        [ ::Time.at(0), ::Time.utc(2010, 8, 5, 12, 15, 00) ]
      end

      def is_value?(value)
        value.kind_of?(::Time)
      end
  
      def parse_literal(str)
        str = str.to_s.strip
        if str =~ /^\(Time (.*)\)$/
          ::Time::parse($1)
        else
          __not_a_literal__!(self, str)
        end
      end
  
      def to_literal(value)
        "(Time #{value.inspect.inspect})"
      end
      
      def coerce(x)
        if is_value?(x)
          x
        elsif x.kind_of?(::String)
          begin
            ::Time::parse(x)
          rescue 
            parse_literal(x)
          end
        else
          super
        end
      end
      
    end # module TimeDomain
  end # module R
end # module SByC