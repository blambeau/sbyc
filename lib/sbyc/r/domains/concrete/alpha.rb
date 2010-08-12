module SByC
  module R
    module AlphaDomain
      
      # Returns the domain of a value
      def most_specific_domain_of(value)
        value.respond_to?(:sbyc_domain) ? value.sbyc_domain : R::Domain::coerce(value.class)
      end
    
    end # module AlphaDomain
  end # module R
end # module SByC