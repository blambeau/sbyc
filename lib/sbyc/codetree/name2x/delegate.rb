module SByC
  module CodeTree
    module Name2X
      class Delegate
      
        # Hash delegate
        attr_reader :delegate
      
        # Creates FromHash instance
        def initialize(delegate)
          @delegate = delegate
        end
      
        # Converts an argument to a sub-class of this
        # delegate implementation
        def self.coerce(arg)
          case arg
            when Delegate
              arg
            when Hash, Proc
              Delegate.new(arg)
            when Module
              ModuleDelegate.new(arg)
            else
              if arg.respond_to?(:[])
                Delegate.new(arg)
              else
                raise ArgumentError, "Unable to convert #{arg} to a Name2X::Delegate", caller
              end
          end
        end
      
        # Make a fetch on from_hash
        def fetch(name)
          delegate[name]
        end
      
        # Convert a name to a module
        def name2module(name)
          result = fetch(name)
          result.kind_of?(Module) ? result : nil
        end
      
        # Convert a name to a class
        def name2class(name)
          result = fetch(name)
          result.kind_of?(Class) ? result : nil
        end
      
        # Convert a name to another name
        def name2name(name)
          result = fetch(name)
          result.kind_of?(Symbol) ? result : nil
        end
      
      end # class FromHash
    end # module Name2X
  end # module CodeTree
end # module SByC