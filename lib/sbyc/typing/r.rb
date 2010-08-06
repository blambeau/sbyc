require 'time'
require 'date'
require 'sbyc/typing/r/operator'
require 'sbyc/typing/r/domain'
require 'sbyc/typing/r/boolean'
require 'sbyc/typing/r/string'
require 'sbyc/typing/r/integer'
require 'sbyc/typing/r/float'
require 'sbyc/typing/r/time'
require 'sbyc/typing/r/date'
require 'sbyc/typing/r/symbol'
require 'sbyc/typing/r/regexp'
require 'sbyc/typing/r/module'
require 'sbyc/typing/r/class'
require 'sbyc/typing/r/system'
module SByC
  module Typing
    module R
      extend Typing::Robustness
      extend Typing::R::System
      
      # Returns a R::Time value
      def Time(str)
        ::Time::parse(str)
      end
      
      # Returns a R::Date value
      def Date(str)
        ::Date::parse(str)
      end
      
      extend(R)
    end # module R
  end # module Typing
end # module SByC