module SByC
  module R
    module Domains
      module UnionDomain

        # Returns true if a given value belongs to this domain,
        # false otherwise
        def is_value?(value)
          sub_domains.any?{|sub| sub.is_value?(value)}
        end
  
        # Parses a literal from the domain and returns
        # a value
        def parse_literal(str)
          sub_domains.each{|sub|
            begin
              return sub.parse_literal(str)
            rescue SByC::TypeError
            end
          }
          __not_a_literal__!(self, str)
        end
        alias :str_coerce :parse_literal
  
        # Converts a value to a literal
        def to_literal(value)
          sub = sub_domains.find{|sub| sub.is_value?(value)}
          sub ? sub.to_literal(value) : __not_a_literal__!(self, value)
        end

      end # module UnionDomain
    end # module Domains
  end # module R
end # module SByC