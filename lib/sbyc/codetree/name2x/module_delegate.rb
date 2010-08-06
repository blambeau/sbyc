module SByC
  module CodeTree
    module Name2X
      class ModuleDelegate < Delegate
      
        # Overrides the default behavior to use const_get instead.
        def fetch(name)
          name = name2name(name)
          delegate.const_defined?(name) ? delegate.const_get(name) : nil
        rescue NameError
          nil
        end
      
        # Capitalize a name
        def name2name(name)
          src = name.to_s
          src.gsub!(/[^a-zA-Z\s]/," ")
          src = " " + src.split.join(" ")
          src.gsub!(/ (.)/) { $1.upcase }    
          src.to_sym
        end
      
      end # class ModuleDelegate
    end # module Name2X
  end # module CodeTree
end # module SByC