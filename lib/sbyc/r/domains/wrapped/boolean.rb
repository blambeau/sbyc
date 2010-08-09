module SByC
  module R
    module BooleanDomain
      
      # Returns true if a given value belongs to this domain,
      # false otherwise
      def is_value?(value)
        value == true || value == false
      end
  
      # Parses a literal from the domain and returns
      # a value
      def parse_literal(str)
        str = str.to_s.strip
        if str == 'true'
          return true
        elsif str == 'false'
          return false
        else
          __not_a_literal__!(self, str)
        end
      end
      alias :str_coerce :parse_literal
  
      # Converts a value to a literal
      def to_literal(value)
        value == true ? "true" : "false"
      end
      
    end # module BooleanDomain
    Boolean = R::CreateDomain(:Boolean, BooleanDomain)
  end # module R
end # module SByC