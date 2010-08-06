module SByC
  module Typing
    module R
      class Class < R::Module
        
        class << self
          
          # Returns true if a given value belongs to this domain,
          # false otherwise
          def is_value?(value)
            value.kind_of?(::Class)
          end
            
        end # class << self
        
      end # class Class
    end # module R
  end # module Typing
end # module SByC