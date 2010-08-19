module SByC
  module CodeTree
    module Parsing
      class TextParser
        include Parsing::Utils
        
        # Source text
        attr_reader :source_text
        
        # Current index in source
        attr_accessor :index
        
        def initialize(source_text)
          @source_text = source_text
          @index = 0
        end
        
        def self.parse(code, options)
          TextParser.new(code).parse(options)
        end
        
        def parse(options = {})
          result = if options[:multiline]
            collected = []
            each(options){|x| collected << x}
            collected
          elsif m = options[:parse_method]
            self.send(m)
          else
            parse_statement
          end
          if options[:eof] and !eof?
            parse_failure!("EOF")
          end
          result
        end

        # Yields the block with each statement in turn
        def each(options = {})
          until eof?
            if m = options[:parse_method]
              self.send(m)
            else
              yield(parse_statement)
            end
            eat_spaces
          end
        end
        
        
        ### Utilities
        
        def current_char
          @source_text[@index, 1]
        end
        
        def eof?
          @index >= @source_text.length
        end
        
        def column(index = @index, str = @source_text)
          return 1 if index == 0
          newline_index = str.rindex("\n", index - 1)
          if newline_index
            index - newline_index
          else
            index + 1
          end
        end
  
        def line(index = @index, str = @source_text)
          str[0...index].count("\n") + 1
        end

        def node(function, children)
          AstNode.new(function, children)
        end

        def literal_node(literal)
          AstNode.new(:_, [ literal ])
        end
        
        def variable_node(name)
          AstNode.new(:'?', [literal_node(name)])
        end
        
        def args_node(names, values)
          AstNode.new(:args, [literal_node(names), literal_node(values)])
        end
        
        # Resolves a given domain
        def resolve_domain(str)
          begin
            literal_node(Kernel.eval(str))
          rescue Exception 
            str.to_sym
          end
        end
        
        ### parsing methods
        
        def parse_failure!(expected)
          got = (@index >= @source_text.length) ? "EOF" : @source_text[@index, 10]
          got.gsub! /\t/, '\t'
          got.gsub! /\n/, '\n'
          msg = "Expected #{expected} at #{line}:#{column}, got '#{got}'"
          raise CodeTree::ParseError, msg, caller
        end
        
        def parse_regexp(rx, expected = nil)
          if @source_text.index(rx,@index)==@index
            @index += $&.length
            $&
          else
            parse_failure!(expected || rx)
          end
        end
        
        def eat_spaces
          parse_regexp(SPACES_REGEXP)
        end
        
        def eat_spaces_or_comma
          eat_spaces
          while current_char == ','
            @index += 1
            eat_spaces
          end
        end
        
        def parse_string(s, eat_s = false)
          if @source_text.index(s,@index)==@index
            @index += s.length
            self.eat_spaces if eat_s
            s
          else
            parse_failure!(s)
          end
        end

        ### statements
        
        # Parses a single statement
        def parse_statement
          eat_spaces
          char = current_char
          if char == "&"
            parse_special_expression_form
          elsif char == '('
            parse_operator_call
          elsif char >= 'A' and char <= 'Z'
            begin
              parse_domain_matcher
            rescue ParseError
              begin
                parse_domain_generation
              rescue ParseError
                parse_literal
              end
            end
          else
            parse_literal
          end
        end
        
        # Parses a special Expression form
        def parse_special_expression_form
          begin
            idx_backup = @index
            parse_string("&", false)
            ast = parse_statement
            node(:Expression, [ ast ])
          rescue ParseError
            @index = idx_backup
            raise
          end
        end
        
        ### domain matching
        def parse_domain_matcher
          index_backup = @index
          domain = parse_domain_literal
          if current_char == '+'
            @index += 1
            node(:+, [ node(:Matcher, [ domain ]) ])
          elsif current_char == '*'
            @index += 1
            node(:*, [ node(:Matcher, [ domain ]) ])
          else
            @index = index_backup
            parse_failure!('+ or *')
          end
        end
        
        ### domain generation
        def parse_domain_generation
          index_backup = @index
          begin
            generator = parse_regexp(DOMAIN_REGEXP, "domain")
            parse_string('<', true)
            args = parse_operator_args
            parse_string('>', true)
            node(:"#{generator}Domain", args)
          rescue ParseError
            @index = index_backup
            raise
          end
        end
        
        ### operator call 
        
        def parse_operator_call
          parse_string('(', true)
          name = parse_operator_name
          eat_spaces
          args = parse_operator_args
          eat_spaces
          parse_string(')', true)
          node(name, args)
        end
        
        def parse_operator_name
          parse_regexp(OPERATOR_NAME_REGEXP, 'operator name').to_sym
        end
        
        def parse_operator_args
          args = []
          while true
            begin
              args << parse_statement
              eat_spaces_or_comma
            rescue ParseError
              break
            end
          end
          args
        end

        ### literals
        
        LITERALS_LOOKUP = {}
        ['+', '-'].each{|x| LITERALS_LOOKUP[x]      = :parse_numeric_literal   }
            (0..9).each{|x| LITERALS_LOOKUP[x.to_s] = :parse_numeric_literal   }
             ['$'].each{|x| LITERALS_LOOKUP[x.to_s] = :parse_variable_literal  }
        ('a'..'z').each{|x| LITERALS_LOOKUP[x]      = :parse_ambiguous_literal }
        ('A'..'Z').each{|x| LITERALS_LOOKUP[x]      = :parse_domain_literal    }
             [':'].each{|x| LITERALS_LOOKUP[x]      = :parse_symbol_literal    }
        ['"', "'"].each{|x| LITERALS_LOOKUP[x]      = :parse_string_literal    }
             ['/'].each{|x| LITERALS_LOOKUP[x]      = :parse_regexp_literal    }
             ['{'].each{|x| LITERALS_LOOKUP[x]      = :parse_args_literal      }
             ['['].each{|x| LITERALS_LOOKUP[x]      = :parse_array_literal     }
             
        
        
        def parse_literal
          method = LITERALS_LOOKUP[current_char]
          if method
            self.send(method)
          else
            parse_failure!("literal")
          end
        end
        
        def parse_numeric_literal
          begin 
            parse_float_literal 
          rescue CodeTree::ParseError
            parse_integer_literal
          end
        end
        
        def parse_integer_literal
          literal_node(parse_regexp(INTEGER_REGEXP, "integer").to_i)
        end
        
        def parse_float_literal
          literal_node(parse_regexp(FLOAT_REGEXP, "float").to_f)
        end
        
        def parse_domain_literal
          resolve_domain(parse_regexp(DOMAIN_REGEXP, "domain"))
        end
        
        def parse_domain_generation_literal
          index_backup = @index
          begin
            generator = parse_regexp(DOMAIN_REGEXP, "domain")
            if current_char != '<'
              resolve_domain(generator)
            else
              parse_string('<', true)
              args = parse_domain_generation_commalist
              parse_string('>', true)
              node(:"#{generator}Domain", args)
            end
          rescue ParseError
            @index = index_backup
            raise
          end
        end
        
        def parse_domain_generation_commalist
          args = []
          args << parse_domain_generation_literal
          eat_spaces_or_comma
          while true
            begin
              args << parse_domain_generation_literal
              eat_spaces_or_comma
            rescue ParseError
              break
            end
          end
          args
        end
        
        def parse_symbol_literal
          begin
            literal_node(Kernel.eval(parse_regexp(SYMBOL_REGEXP, "symbol")))
          rescue CodeTree::ParseError
            raise
          rescue Exception => ex
            parse_failure!(SYMBOL_REGEXP)
          end
        end
        
        def parse_string_literal
          char = current_char
          str = if char == '"'
            parse_regexp(DOUBLE_QUOTED_STRING_REGEXP, "string literal")
          elsif char == "'"
            parse_regexp(SINGLE_QUOTED_STRING_REGEXP, "string literal")
          else
            parse_failure!("string literal")
          end
          begin
            str = literal_node(Kernel.eval(str))
          rescue Exception => ex
            parse_failure!("string literal")
          end
        end
        
        def parse_regexp_literal
          begin
            literal_node(Kernel.eval(parse_regexp(REGEXP_REGEXP, "regular expression")))
          rescue CodeTree::ParseError
            raise
          rescue Exception => ex
            parse_failure!(REGEXP_REGEXP)
          end
        end
        
        def parse_ambiguous_literal
          begin
            parse_variable_literal
          rescue CodeTree::ParseError
            parse_boolean_literal
          end
        end
          
        def parse_boolean_literal
          literal_node(parse_regexp(BOOLEAN_REGEXP, "boolean") == "true" ? true : false)
        end
        
        def parse_variable_literal
          index = @index
          str = parse_regexp(VARIABLE_NAME_REGEXP, "variable")
          if KEYWORDS.include?(str)
            @index = index
            parse_failure!("variable") 
          end
          variable_node(str.to_sym)
        end
        
        # Parses an array literal
        def parse_array_literal
          backup_index = @index
          parse_string('[', true)
          args = []
          while true
            begin
              args << parse_statement
              eat_spaces_or_comma
            rescue ParseError
              break
            end
          end
          parse_string(']', true)
          node(:Array, args)
        rescue ParseError
          @index = backup_index
        end

        def parse_args_literal
          parse_string('{-', true)
          names, values = [], []
          while (char = current_char) != '-'
            name, value = parse_arg_literal
            names << name
            values << value
            eat_spaces_or_comma
          end
          parse_string('-}')
          args_node(names, values)
        end
        
        def parse_arg_literal
          name = parse_variable_literal.literal
          parse_string(':', true)
          value = parse_literal.literal
          [name, value]
        end
        
      end # class TextParser
    end # module Parsing
  end # module CodeTree
end # module SByC