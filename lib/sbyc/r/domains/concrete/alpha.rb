module SByC
  module R
    module AlphaDomain
      
      # Creates the Alpha domain
      def self.factor
        R::DomainDomain.create(:Alpha, [AbstractDomain::Union, R::AlphaDomain])
      end
      
    end # module AlphaDomain
  end # module R
end # module SByC