require 'sbyc/r/domains/abstract/contract'
require 'sbyc/r/domains/abstract/hierarchy'
require 'sbyc/r/domains/abstract/operators'
require 'sbyc/r/domains/abstract/domain'
require 'sbyc/r/domains/abstract/union'
require 'sbyc/r/domains/abstract/reuse'
module SByC
  module R
    module AbstractDomain
      include R::Robustness
      include R::AbstractDomain::Contract
      include R::AbstractDomain::Hierarchy
      include R::AbstractDomain::Operators
    end
  end
end