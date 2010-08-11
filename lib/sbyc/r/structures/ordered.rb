module SByC
  module R
    module Ordered
      
      # Installs the structure on a given domain
      def self.install(r, domain)
        r.wrap_operator([:compare, :'<=>'], [ domain, domain ], r::Integer)
        r.wrap_operator([:gt,      :'>'],   [ domain, domain ], r::Boolean)
        r.wrap_operator([:gte,     :'>='],  [ domain, domain ], r::Boolean)
        r.wrap_operator([:lt,      :'<'],   [ domain, domain ], r::Boolean)
        r.wrap_operator([:lte,     :'<='],  [ domain, domain ], r::Boolean)
        domain.add_structure(self)
      end
      
    end # module Ordered
  end # module R
end # module SByC
