require 'sbyc/codetree/parsing/text_parser'
require 'sbyc/codetree/parsing/proc_parser'
module SByC
  module CodeTree
    module Parsing
      
      def parse(code, options = nil, &block)
        if code.kind_of?(Hash) and options.nil?
          code, options = nil, code 
        end
        code = code || block
        case code
          when String
            TextParser::parse(code, options || {})
          when Proc
            ProcParser::parse(code, options || {})
        end
      end
      module_function :parse
      
    end # module Parsing
  end # module CodeTree
end # module SByC
