require 'sbyc/typing/r/domain/operator_methods'
require 'sbyc/typing/r/domain/common_methods'
require 'sbyc/typing/r/domain/prinstine_methods'
require 'sbyc/typing/r/domain/root_methods'
module SByC
  module Typing
    module R
      class Domain
        extend Typing::R::Robustness
        extend R::Domain::CommonMethods
      end # class Domain
      R::Domain.extend(R::Domain::RootMethods)
    end # module R
  end # module Typing
end # module SByC