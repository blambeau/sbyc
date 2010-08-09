require 'time'
require 'date'
require 'sbyc/r/robustness'
require 'sbyc/r/operator'
require 'sbyc/r/domain'
require 'sbyc/r/domains'
require 'sbyc/r/operators'
require 'sbyc/r/system'
module SByC
  module R
    extend R::Robustness
    extend R::System
    
    extend(R)
  end # module R
end # module SByC
require 'sbyc/r/system/bool_op'
require 'sbyc/r/system/string_op'
require 'sbyc/r/system/integer_op'
require 'sbyc/r/system/float_op'
