module SByC
  module Typing
    module Robustness
    
      # Raised when a type error occurs
      class ::SByC::TypeError < ::SByC::Error; end
    
      # Finds a ruby module by name or returns nil
      def __find_ruby_module__(name, start = ::Kernel)
        name = name.to_s.strip
        if name.empty?
          nil
        else
          begin
            parts, current = name.split("::"), start
            parts.each{|part| current = current.const_get(part.to_sym)}
            current
          rescue Exception => ex
            nil
          end
        end
      end
    
      # Raises a TypeError with a message explaining that _str_
      # is not a literal for _domain_
      def __not_a_literal__!(domain, str, cal = caller)
        raise ::SByC::TypeError, "Invalid domain literal #{str.inspect} for #{domain.name}", cal
      end
    
      extend(Robustness)
    end # module Robustness
  end # module Typing
end # module SByC