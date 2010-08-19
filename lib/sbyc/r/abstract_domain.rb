require 'sbyc/r/abstract_domain/contract'
require 'sbyc/r/abstract_domain/hierarchy'
module SByC
  module R
    module AbstractDomain
      include R::Robustness
      include R::AbstractDomain::Contract
      include R::AbstractDomain::Hierarchy
      include R::Callable
    end
  end
end
