module SByC
  module CodeTree
    module Parsing
      class Parser
        
        INTEGER_REGEXP = /^0|[1-9]+/
        
        # Source text
        attr_reader :source_text
        
        # Current index in source
        attr_reader :index
        
        def initialize(source_text)
          @source_text = source_text
          @index = 0
        end
        
        ### Utilities
        
        def parse_failure!(expected)
          msg = "Expected #{expected} at #{@index}, got #{@source_text[@index, 1]}"
          raise CodeTree::ParseError, msg
        end
        
        def literal_node(literal)
          AstNode.new(:_, [ literal ])
        end
        
        ### parsing methods
        
        def parse_regexp(rx)
          if @source_text.index(rx,@index)==@index
            @index = @index + $&.length
            $&
          else
            parse_failure!(rx)
          end
        end
        
        def parse_integer_literal
          literal_node(parse_regexp(INTEGER_REGEXP).to_i)
        end
        
      end # class Parser
    end # module Parsing
  end # module CodeTree
end # module SByC