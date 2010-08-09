require 'sbyc/r/domain/common_methods'
require 'sbyc/r/domain/prinstine_methods'
require 'sbyc/r/domain/root_methods'
module SByC
  module R
    class Domain
      extend R::Robustness
      extend R::Domain::CommonMethods
    end # class Domain
    R::Domain.extend(R::Domain::RootMethods)
  end # module R
end # module SByC