require 'time'
require 'date'
require 'sbyc/r/robustness'
require 'sbyc/r/system'
module SByC
  module R
    extend R::Robustness
    extend R::System
    
    # Returns all known domains
    def __all_domains__
      @__all_domains__ ||= []
    end
    
    def domains
      __all_domains__
    end
    
    def WrapRubyDomain(ruby_classes, class_methods)
      c = Class.new
      c.extend(R::Robustness)
      c.extend(R::DomainImpl::CommonMethods)
      c.extend(class_methods)
      __all_domains__ << c
      c
    end
    
    extend(R)
  end # module R
end # module SByC


require 'sbyc/r/domain_impl'
require 'sbyc/r/domains'

require 'sbyc/r/operators'
require 'sbyc/r/operator'

require 'sbyc/r/system/bool_op'
require 'sbyc/r/system/string_op'
require 'sbyc/r/system/integer_op'
require 'sbyc/r/system/float_op'
