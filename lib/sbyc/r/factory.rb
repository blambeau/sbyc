module SByC
  module R
    module Factory
      
      # Factors a signature instance
      def signature(*domains)
        R::Operator::Signature.new(domains)
      end
      
      # Factors a signature instance
      def aggregate_signature(domain)
        R::Operator::Signature::aggregate(domain)
      end
      
      # Factors a pairs instance
      def paired_signature(key_domain, value_domain)
        R::Operator::Signature::paired(key_domain, value_domain)
      end
      
    end # module Factory
  end # module R
end # module SByC