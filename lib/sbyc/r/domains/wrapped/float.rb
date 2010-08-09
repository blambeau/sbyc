module SByC
  module R
    class Float < R::Domain
      
      class << self
        
        # Returns true if a given value belongs to this domain,
        # false otherwise
        def is_value?(value)
          value.kind_of?(::Float)
        end
    
        # Parses a literal from the domain and returns
        # a value
        def parse_literal(str)
          str = str.to_s.strip
          if str =~ /^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$/
            return str.to_f
          else
            __not_a_literal__!(self, str)
          end
        end
        alias :str_coerce :parse_literal
    
        # Converts a value to a literal
        def to_literal(value)
          value.inspect
        end
    
      end # class << self
      
    end # class Float
  end # module R
end # module SByC