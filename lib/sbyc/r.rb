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
      
      # Create the domain and builds it
      c = Class.new
      [ AbstractDomain::Domain, 
        class_methods ].flatten.each{|mod| c.extend(mod)}
      c.const_set(:Operators, R::AbstractDomain::OperatorSet.factor(c))
        
      # Trace it
      domains << c
      
      # Returns it
      c
    end
    
    def CreateUnionDomain(name, class_methods)
      c = CreateDomain(name, [ AbstractDomain::Union, class_methods ])
      unless name == :Alpha
        R::Alpha.add_sub_domain(c)
        c.add_super_domain(R::Alpha)
      end
      c
    end
    
    def RefineUnionDomain(name, union_domain, class_methods)
      c = CreateDomain(name, class_methods)
      union_domain.add_sub_domain(c)
      c.add_super_domain(union_domain)
      c
    end
    
    extend(R)
  end # module R
end # module SByC

require 'sbyc/r/domains'
require 'sbyc/r/structures'

require 'sbyc/r/operators'
require 'sbyc/r/operator'

require 'sbyc/r/system/alpha'

require 'sbyc/r/system/string_op'
require 'sbyc/r/system/numeric_op'
require 'sbyc/r/system/integer_op'
require 'sbyc/r/system/float_op'

require 'sbyc/r/system/boolean'
require 'sbyc/r/system/string'