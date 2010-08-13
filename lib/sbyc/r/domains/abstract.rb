require 'sbyc/r/domains/abstract/hierarchy'
require 'sbyc/r/domains/abstract/union'
module SByC
  module R
    module AbstractDomain
      include R::Robustness
      include R::AbstractDomain::Contract
      include R::AbstractDomain::Hierarchy
    end
  end
end