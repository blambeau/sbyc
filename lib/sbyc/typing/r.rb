require 'time'
require 'date'
require 'sbyc/typing/r/robustness'
require 'sbyc/typing/r/operator'
require 'sbyc/typing/r/domain'
require 'sbyc/typing/r/domains'
require 'sbyc/typing/r/system'
module SByC
  module Typing
    module R
      extend Typing::R::Robustness
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
require 'sbyc/typing/r/system/bool_op'
require 'sbyc/typing/r/system/string_op'
require 'sbyc/typing/r/system/integer_op'
