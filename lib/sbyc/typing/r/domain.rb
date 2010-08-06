require 'sbyc/typing/r/domain/prinstine_methods'
require 'sbyc/typing/r/domain/root_methods'
module SByC
  module Typing
    module R
      class Domain
        extend Typing::Robustness
      end # class Domain
      R::Domain.extend(R::Domain::RootMethods)
    end # module R
  end # module Typing
end # module SByC