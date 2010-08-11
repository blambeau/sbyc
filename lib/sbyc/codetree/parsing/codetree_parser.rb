module SByC
  module CodeTree
    module Parsing
      
      module ParserMethods
        
        def root() :main; end
        def _nt_main(r)
          result=already_found?(r, :main)
          return result if result
          result = (r_1 = (optional r, (_nt_spacing r)) and
                    r_2 = (one_or_more r_1 do |r_1_0| 
                             r_1_0_1 = (_nt_statement r_1_0) and
                             r_1_0_2 = (_nt_newline r_1_0_1) and
                             
                             (accumulate r_1_0, [:statement, :newline], [r_1_0_1, r_1_0_2])
                           end) and
                    r_3 = (optional r_2, (_nt_spacing r_2)) and
                    
                    (accumulate r, [nil, nil, nil], [r_1, r_2, r_3]))
          (memoize r, :main, result) if result
        end
        def _nt_statement(r)
          result=already_found?(r, :statement)
          return result if result
          result = ((_nt_literal r) or
                    (_nt_opcall r) or
                     nil)
          (memoize r, :statement, result) if result
        end
        def _nt_opcall(r)
          result=already_found?(r, :opcall)
          return result if result
          result = ((add_semantic_types (r_1 = (terminal r, '(') and
                                         r_2 = (_nt_opname r_1) and
                                         r_3 = (_nt_spacing r_2) and
                                         r_4 = (_nt_opargs r_3) and
                                         r_5 = (terminal r_4, ')') and
                                         
                                         (accumulate r, [nil, :name, :spacing, :args, nil], [r_1, r_2, r_3, r_4, r_5])), [:opcall]))
          (memoize r, :opcall, result) if result
        end
        def _nt_opname(r)
          result=already_found?(r, :opname)
          return result if result
          result = (((add_semantic_types (r_1 = (regexp r, '[\\w]+') and
                                          r_2 = (zero_or_more r_1 do |r_1_0| 
                                                   r_1_0_1 = (terminal r_1_0, ':') and
                                                   r_1_0_2 = (regexp r_1_0_1, '[\\w]+') and
                                                   
                                                   (accumulate r_1_0, [nil, nil], [r_1_0_1, r_1_0_2])
                                                 end) and
                                          
                                          (accumulate r, [nil, nil], [r_1, r_2])), [:opname])) or
                    ((add_semantic_types (r_1 = (one_or_more r do |r_0| 
                                                   r_0_1 = (negative_lookahead? r_0, (regexp r_0, '[\\s:]')) and
                                                   r_0_2 = (anything r_0_1) and
                                                   
                                                   (accumulate r_0, [nil, nil], [r_0_1, r_0_2])
                                                 end) and
                                          r_2 = (zero_or_more r_1 do |r_1_0| 
                                                   r_1_0_1 = (regexp r_1_0, '[:]') and
                                                   r_1_0_2 = (one_or_more r_1_0_1 do |r_1_0_1_0| 
                                                                r_1_0_1_0_1 = (negative_lookahead? r_1_0_1_0, (regexp r_1_0_1_0, '[\\s:]')) and
                                                                r_1_0_1_0_2 = (anything r_1_0_1_0_1) and
                                                                
                                                                (accumulate r_1_0_1_0, [nil, nil], [r_1_0_1_0_1, r_1_0_1_0_2])
                                                              end) and
                                                   
                                                   (accumulate r_1_0, [nil, nil], [r_1_0_1, r_1_0_2])
                                                 end) and
                                          
                                          (accumulate r, [nil, nil], [r_1, r_2])), [:opname])) or
                     nil)
          (memoize r, :opname, result) if result
        end
        def _nt_opargs(r)
          result=already_found?(r, :opargs)
          return result if result
          result = (r_1 = (_nt_oparg r) and
                    r_2 = (zero_or_more r_1 do |r_1_0| 
                             r_1_0_1 = (_nt_opspacing r_1_0) and
                             r_1_0_2 = (_nt_oparg r_1_0_1) and
                             
                             (accumulate r_1_0, [:opspacing, :oparg], [r_1_0_1, r_1_0_2])
                           end) and
                    
                    (accumulate r, [:head, :tail], [r_1, r_2]))
          (memoize r, :opargs, result) if result
        end
        def _nt_oparg(r)
          result=already_found?(r, :oparg)
          return result if result
          result = ((_nt_literal r) or
                    (_nt_opcall r) or
                     nil)
          (memoize r, :oparg, result) if result
        end
        def _nt_opspacing(r)
          result=already_found?(r, :opspacing)
          return result if result
          result = (r_1 = (regexp r, '[ \\t\\n]+') and
                    r_2 = (regexp r_1, '[,]?') and
                    r_3 = (regexp r_2, '[ \\t\\n]*') and
                    
                    (accumulate r, [nil, nil, nil], [r_1, r_2, r_3]))
          (memoize r, :opspacing, result) if result
        end
        def _nt_literal(r)
          result=already_found?(r, :literal)
          return result if result
          result = ((_nt_boolean_literal r) or
                    (_nt_string_literal r) or
                    (_nt_float_literal r) or
                    (_nt_integer_literal r) or
                    (_nt_regexp_literal r) or
                    (_nt_domain_literal r) or
                    (_nt_symbol_literal r) or
                     nil)
          (memoize r, :literal, result) if result
        end
        def _nt_boolean_literal(r)
          result=already_found?(r, :boolean_literal)
          return result if result
          result = ((terminal r, 'true') or
                    ((add_semantic_types (terminal r, 'false'), [:boolean_literal])) or
                     nil)
          (memoize r, :boolean_literal, result) if result
        end
        def _nt_string_literal(r)
          result=already_found?(r, :string_literal)
          return result if result
          result = (((add_semantic_types (r_1 = (terminal r, '"') and
                                          r_2 = (zero_or_more r_1 do |r_1_0| 
                                                   r_1_0_1 = (negative_lookahead? r_1_0, (terminal r_1_0, '"')) and
                                                   r_1_0_2 = ((terminal r_1_0_1, "\\\\") or
                                                              (terminal r_1_0_1, '\"') or
                                                              (anything r_1_0_1) or
                                                               nil) and
                                                   
                                                   (accumulate r_1_0, [nil, nil], [r_1_0_1, r_1_0_2])
                                                 end) and
                                          r_3 = (terminal r_2, '"') and
                                          
                                          (accumulate r, [nil, :string, nil], [r_1, r_2, r_3])), [:string_literal])) or
                    ((add_semantic_types (r_1 = (terminal r, "'") and
                                          r_2 = (zero_or_more r_1 do |r_1_0| 
                                                   r_1_0_1 = (negative_lookahead? r_1_0, (terminal r_1_0, "'")) and
                                                   r_1_0_2 = ((terminal r_1_0_1, "\\\\") or
                                                              (terminal r_1_0_1, "\\'") or
                                                              (anything r_1_0_1) or
                                                               nil) and
                                                   
                                                   (accumulate r_1_0, [nil, nil], [r_1_0_1, r_1_0_2])
                                                 end) and
                                          r_3 = (terminal r_2, "'") and
                                          
                                          (accumulate r, [nil, :string, nil], [r_1, r_2, r_3])), [:string_literal])) or
                     nil)
          (memoize r, :string_literal, result) if result
        end
        def _nt_float_literal(r)
          result=already_found?(r, :float_literal)
          return result if result
          result = ((add_semantic_types (r_1 = ((regexp r, '[0]') or
                                                (regexp r, '[1-9]*') or
                                                 nil) and
                                         r_2 = (terminal r_1, '.') and
                                         r_3 = (regexp r_2, '[0-9]+') and
                                         
                                         (accumulate r, [nil, nil, nil], [r_1, r_2, r_3])), [:float_literal]))
          (memoize r, :float_literal, result) if result
        end
        def _nt_integer_literal(r)
          result=already_found?(r, :integer_literal)
          return result if result
          result = ((terminal r, '0') or
                    ((add_semantic_types (regexp r, '[1-9]+'), [:integer_literal])) or
                     nil)
          (memoize r, :integer_literal, result) if result
        end
        def _nt_regexp_literal(r)
          result=already_found?(r, :regexp_literal)
          return result if result
          result = ((add_semantic_types (r_1 = (terminal r, '/') and
                                         r_2 = (one_or_more r_1 do |r_1_0| 
                                                  r_1_0_1 = (negative_lookahead? r_1_0, (terminal r_1_0, '/')) and
                                                  r_1_0_2 = (anything r_1_0_1) and
                                                  
                                                  (accumulate r_1_0, [nil, nil], [r_1_0_1, r_1_0_2])
                                                end) and
                                         r_3 = (terminal r_2, '/') and
                                         
                                         (accumulate r, [nil, nil, nil], [r_1, r_2, r_3])), [:regexp_literal]))
          (memoize r, :regexp_literal, result) if result
        end
        def _nt_domain_literal(r)
          result=already_found?(r, :domain_literal)
          return result if result
          result = ((add_semantic_types (r_1 = (_nt_ruby_constant_literal r) and
                                         r_2 = (zero_or_more r_1 do |r_1_0| 
                                                  r_1_0_1 = (terminal r_1_0, '::') and
                                                  r_1_0_2 = (_nt_ruby_constant_literal r_1_0_1) and
                                                  
                                                  (accumulate r_1_0, [nil, :ruby_constant_literal], [r_1_0_1, r_1_0_2])
                                                end) and
                                         
                                         (accumulate r, [:ruby_constant_literal, nil], [r_1, r_2])), [:domain_literal]))
          (memoize r, :domain_literal, result) if result
        end
        def _nt_ruby_constant_literal(r)
          result=already_found?(r, :ruby_constant_literal)
          return result if result
          result = (r_1 = (regexp r, '[A-Z]') and
                    r_2 = (regexp r_1, '[a-z0-9_]*') and
                    
                    (accumulate r, [nil, nil], [r_1, r_2]))
          (memoize r, :ruby_constant_literal, result) if result
        end
        def _nt_symbol_literal(r)
          result=already_found?(r, :symbol_literal)
          return result if result
          result = ((add_semantic_types (r_1 = (terminal r, ':') and
                                         r_2 = (one_or_more r_1 do |r_1_0| 
                                                  r_1_0_1 = (negative_lookahead? r_1_0, (regexp r_1_0, '[\\s:]')) and
                                                  r_1_0_2 = (anything r_1_0_1) and
                                                  
                                                  (accumulate r_1_0, [nil, nil], [r_1_0_1, r_1_0_2])
                                                end) and
                                         
                                         (accumulate r, [nil, nil], [r_1, r_2])), [:symbol_literal]))
          (memoize r, :symbol_literal, result) if result
        end
        def _nt_spacing(r)
          result=already_found?(r, :spacing)
          return result if result
          result = (regexp r, '[ \\t\\n]*')
          (memoize r, :spacing, result) if result
        end
        def _nt_newline(r)
          result=already_found?(r, :newline)
          return result if result
          result = (regexp r, '[\\n]')
          (memoize r, :newline, result) if result
        end
        def _nt_spaces_or_eof(r)
          result=already_found?(r, :spaces_or_eof)
          return result if result
          result = ((regexp r, '[ \\t]+') or
                    (negative_lookahead? r, (regexp r, '[a-zA-Z0-9_]')) or
                    (negative_lookahead? r, (anything r)) or
                     nil)
          (memoize r, :spaces_or_eof, result) if result
        end
    
      end
      
      class Parser < Anagram::Parsing::CompiledParser
        include ParserMethods
        def self.<<(input, rule=nil)
          self.new.parse(input, rule)
        end
      end
    end
  end
end