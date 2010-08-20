module SByC
  module R
    module System
      class Core < R::Namespace
        
        def initialize(runner)
          super(runner, :core)
          
          # Domain generators
          self.def(:BuiltinDomain, R::DomainGenerator::Builtin.new(runner))
          self.def(:ArrayDomain,   R::DomainGenerator::Array.new(runner))
          
          # Special ops
          self.def(:def,         Core::DefCallable.new)
          self.def(:fed,         Core::FedCallable.new)
          self.def(:call,        Core::CallCallable.new)
          self.def(:puts,        Core::PutsCallable.new)
          self.def(:namespace,   Core::NamespaceCallable.new)
          self.def(:'ruby-send', Core::RubySendCallable.new)
        end
        
      end # class Core
    end # module System
  end # module R
end # module SByC
require "sbyc/r/system/core/def_callable"
require "sbyc/r/system/core/fed_callable"
require "sbyc/r/system/core/call_callable"
require "sbyc/r/system/core/ruby_send_callable"
require "sbyc/r/system/core/namespace_callable"
require "sbyc/r/system/core/puts_callable"
