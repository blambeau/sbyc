module SByC
  module R
    module Factory
      
      # Factors a signature instance
      def signature(*domains)
        R::Operator::Signature.new(domains)
      end
      
      # Factors a signature instance
      def aggregate_signature(domain)
        R::Operator::AggregateSignature.new(domain)
      end
      
    end # module Factory
  end # module R
end # module SByC