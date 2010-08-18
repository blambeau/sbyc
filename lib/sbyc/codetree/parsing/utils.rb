module SByC
  module CodeTree
    module Parsing
      module Utils
      
        # Keywords
        KEYWORDS = ['true', 'false']
        
        # Regular expression for booleans
        BOOLEAN_REGEXP = /(true|false)/
        
        # Regular expression for integers
        INTEGER_REGEXP = /[-+]?(0|[0-9]+)/
        
        # Regular expression for floats
        FLOAT_REGEXP = /[-+]?[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?/
        
        # Regular expression for symbols
        SYMBOL_REGEXP = /[:]([^\s:\(\),]+)/
        
        # Regular expression for domains
        DOMAIN_NAME               = "[A-Z][A-Z0-9a-z_]*"
        DOMAIN_QUALIFIED_NAME     = "(#{DOMAIN_NAME})(::#{DOMAIN_NAME})*"
        DOMAIN_REGEXP             = /#{DOMAIN_QUALIFIED_NAME}/
        
        # Regular expression for strings
        SINGLE_QUOTED_STRING_REGEXP = /['](([\\][']|[^'])*?)[']/
        
        # Regular expression for strings
        DOUBLE_QUOTED_STRING_REGEXP = /["](([\\]["]|[^"])*?)["]/
        
        # Regular expression for strings
        REGEXP_REGEXP = /[\/]((\\\/|[^\/])*)[\/]/
        
        # Regular expression for spaces
        SPACES_REGEXP = /(\s|[#][^\n]*)*/m
        
        # Regular expression for operator name
        OPERATOR_NAME_REGEXP = /[^\s:\(\),]+/
        
        # Regular expression for variable name
        VARIABLE_NAME_REGEXP = /[$][a-zA-Z0-9-]*|[a-z][a-zA-Z0-9-]*/
        
        extend(Utils)
      end # module Utils
    end # module Parsing
  end # module CodeTree
end # module SByC