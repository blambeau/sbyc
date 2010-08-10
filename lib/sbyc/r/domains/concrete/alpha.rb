module SByC
  module R
    module AlphaDomain
      
      # Returns the domain of a value
      def most_specific_domain_of(value)
        value.respond_to?(:domain) ? value.domain : R::Domain::coerce(value.class)
      end
    
    end # module AlphaDomain
    Alpha = R::CreateUnionDomain(:Alpha, AlphaDomain)
  end # module R
end # module SByC