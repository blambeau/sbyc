module SByC
  module R
    module AlphaDomain
      include Domains::UnionDomain
      
      # Returns the domain of a value
      def most_specific_domain_of(value)
        value.respond_to?(:domain) ? value.domain : R::Domain::coerce(value.class)
      end
    
    end # module AlphaDomain
    Alpha = R::CreateDomain(:Alpha, AlphaDomain)
  end # module R
end # module SByC