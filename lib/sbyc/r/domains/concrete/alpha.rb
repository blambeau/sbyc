module SByC
  module R
    module AlphaDomain
      
      # Creates the Alpha domain
      def self.factor
        R::DomainDomain.create(:Alpha, [AbstractDomain::Union, R::AlphaDomain])
      end
      
      # Returns the domain of a value
      def domain_of(value)
        if value.respond_to?(:sbyc_domain)
          value.sbyc_domain
        else
          R::Domain::coerce(value.class)
        end
      end
      
    end # module AlphaDomain
  end # module R
end # module SByC