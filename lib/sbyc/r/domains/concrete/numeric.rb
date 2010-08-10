module SByC
  module R
    module NumericDomain
    end # module NumericDomain
    Numeric = R::CreateUnionDomain(:Numeric, NumericDomain)
  end # module R
end # module SByC