require 'sbyc/codetree/parsing/parser'
module SByC
  module CodeTree
    module Parsing
      
      def parse(source)
        Parser.instance_eval{ include(Productions) }
        Parser << source
      end
      module_function :parse
      
    end # module Parsing
  end # module CodeTree
end # module SByC
