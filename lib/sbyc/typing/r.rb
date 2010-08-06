require 'time'
require 'date'
require 'sbyc/typing/r/boolean'
require 'sbyc/typing/r/string'
require 'sbyc/typing/r/integer'
require 'sbyc/typing/r/float'
require 'sbyc/typing/r/time'
module SByC
  module Typing
    module R
      
      # Returns a R::Time value
      def Time(str)
        ::Time::parse(str)
      end
      
      extend(R)
    end # module R
  end # module Typing
end # module SByC