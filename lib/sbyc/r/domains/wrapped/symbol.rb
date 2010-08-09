module SByC
  module R
    module SymbolDomain

      # Returns true if a given value belongs to this domain,
      # false otherwise
      def is_value?(value)
        value.kind_of?(::Symbol)
      end
  
      # Parses a literal from the domain and returns
      # a value
      def parse_literal(str)
        str = str.to_s.strip
        if str =~ /^:[^\s]+$/
          begin
            Kernel.eval(str)
          rescue Exception => ex
            __not_a_literal__!(self, str)
          end
        else
          __not_a_literal__!(self, str)
        end
      end
      alias :str_coerce :parse_literal
  
      # Converts a value to a literal
      def to_literal(value)
        value.inspect
      end
      
    end # module SymbolDomain
    Symbol = R::WrapRubyDomain(:Symbol, ::Symbol, SymbolDomain)
  end # module R
end # module SByC