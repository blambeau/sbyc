module SByC
  module R
    module AlphaDomain
      
      # Returns the domain of a value
      def most_specific_domain_of(value)
        R::Domain.is_value?(value) ? R::Domain : R::Domain::coerce(value.class)
      end
    
      # Returns true if a given value belongs to this domain,
      # false otherwise
      def is_value?(value)
        sub_domains.any?{|sd| sd.is_value?(value)}
      end
      
      # Parses a literal from the domain and returns
      # a value
      def parse_literal(literal)
        sub_domains.each{|d| 
          begin
            return d.parse_literal(literal)
          rescue SByC::TypeError
          end
        }
        __not_a_literal__!(self, literal)
      end
      alias :str_coerce :parse_literal
  
      # Converts a value to a literal
      def to_literal(value)
        most_specific_domain_of(value).to_literal(value)
      end

      # Coerces from a ruby value
      def ruby_coerce(value)
        nil
      end
        
    end # module AlphaDomain
    Alpha = R::CreateDomain(:Alpha, AlphaDomain)
  end # module R
end # module SByC