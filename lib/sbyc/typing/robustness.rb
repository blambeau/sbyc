module SByC
  module Typing
    module Robustness
    
      # Raised when a type error occurs
      class ::SByC::TypeError < ::SByC::Error; end
    
      # Raises a TypeError with a message explaining that _str_
      # is not a literal for _domain_
      def __not_a_literal__!(domain, str, cal = caller)
        raise ::SByC::TypeError, "Invalid domain literal #{str} for #{domain.name}", cal
      end
    
    end # module Robustness
  end # module Typing
end # module SByC