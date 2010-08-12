module SByC
  module R
    class DomainGenerator
      
      # Creates a generator instance
      def initialize
        @domains_hash = {}
      end
      
      # Returns known domains
      def domains
        @domains_hash.values
      end
      
      # Tracks creation of domains
      def domain_created(name, domain)
        @domains_hash[name] = domain
        domain
      end
        
    end # class DomainGenerator
  end # module R
end # module SByc
require 'sbyc/r/domains/generator/builtin'
require 'sbyc/r/domains/generator/array'