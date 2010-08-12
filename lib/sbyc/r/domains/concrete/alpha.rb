module SByC
  module R
    module AlphaDomain
      
      # Creates the Alpha domain
      def self.factor
        alpha = Class.new
        [R::AbstractDomain, 
         AbstractDomain::Union, 
         R::AlphaDomain].each{|mod|
           alpha.extend(mod)
        }
        alpha.const_set(:Operators, R::Operator::Set.factor)
        R::domains << alpha
        alpha
      end
      
    end # module AlphaDomain
  end # module R
end # module SByC