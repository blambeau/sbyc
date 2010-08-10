module SByC
  module R
    module ModuleDomain
      
      # Returns true if a given value belongs to this domain,
      # false otherwise
      def is_value?(value)
        value.kind_of?(::Module)
      end
  
      # Parses a literal from the domain and returns
      # a value
      def parse_literal(str)
        found = __find_ruby_module__(str)
        if found and is_value?(found) 
          found
        else
          __not_a_literal__!(self, str)
        end
      end
      alias :str_coerce :parse_literal
  
      # Converts a value to a literal
      def to_literal(value)
        value.name
      end
      
    end # module ModuleDomain
    Module = R::RefineUnionDomain(:Module, Alpha, ModuleDomain)
  end # module R
end # module SByC