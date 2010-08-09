require 'time'
require 'date'
require 'sbyc/r/robustness'
require 'sbyc/r/system'
module SByC
  module R
    extend R::Robustness
    extend R::System
    
    def domains
      @__domains__ ||= []
    end
    
    # Creates a domain
    def CreateDomain(name, class_methods)
      c = Class.new
      [ R::Domains::AbstractDomain, class_methods ].flatten.each{|mod| c.extend(mod)}
      domains << c
      c
    end
    
    def WrapRubyDomain(name, ruby_classes, class_methods)
      CreateDomain(name, [ R::Domains::WrappedDomain, class_methods ])
    end
    
    extend(R)
  end # module R
end # module SByC


require 'sbyc/r/domains'

require 'sbyc/r/operators'
require 'sbyc/r/operator'

require 'sbyc/r/system/bool_op'
require 'sbyc/r/system/string_op'
require 'sbyc/r/system/integer_op'
require 'sbyc/r/system/float_op'
