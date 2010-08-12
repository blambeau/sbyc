module SByC
  module CodeTree
    module Parsing
      class TextParser
        
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
        DOMAIN_REGEXP = /([A-Z][A-Z0-9a-z_]*)(::[A-Z][A-Z0-9a-z_]*)*/
        
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
        VARIABLE_NAME_REGEXP = /[a-z][^\s\(\),:]*/
        
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
        
        def parse(options)
          result = if options[:multiline]
            collected = []
            each{|x| collected << x}
            collected
          else
            parse_statement
          end
          if options[:eof] and !eof?
            parse_failure!("EOF")
          end
          result
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
          Kernel.eval(str)
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
        
        def parse_string(s, eat_s = false)
          if @source_text.index(s,@index)==@index
            @index += s.length
            self.eat_spaces if eat_s
            s
          else
            parse_failure!(rx)
          end
        end

        ### statements
        
        # Yields the block with each statement in turn
        def each
          until eof?
            yield(parse_statement)
            eat_spaces
          end
        end
        
        # Parses a single statement
        def parse_statement
          eat_spaces
          char = current_char
          if char == '('
            parse_operator_call
          else
            parse_literal
          end
        end
        
        ### operator call 
        
        def parse_operator_call
          parse_string('(', true)
          name = parse_operator_name
          eat_spaces
          #puts "Starting operator call #{name} on #{current_char}"
          args = parse_operator_args
          eat_spaces
          parse_string(')', true)
          AstNode.new(name, args)
        end
        
        def parse_operator_name
          parse_regexp(OPERATOR_NAME_REGEXP, 'operator name').to_sym
        end
        
        def parse_operator_args
          args = []
          while ((char = current_char) != ')')
            args << parse_operator_arg(char)
            eat_spaces
            if current_char == ','
              @index += 1
              eat_spaces
            end
            #puts "After having read #{args.last} : #{current_char}"
          end
          args
        end

        def parse_operator_arg(char)
          if char == '('
            parse_operator_call
          else
            parse_literal
          end
        end
        
        ### literals
        
        LITERALS_LOOKUP = {}
        ['+', '-'].each{|x| LITERALS_LOOKUP[x]      = :parse_numeric_literal   }
            (0..9).each{|x| LITERALS_LOOKUP[x.to_s] = :parse_numeric_literal   }
        ('a'..'z').each{|x| LITERALS_LOOKUP[x]      = :parse_ambiguous_literal }
        ('A'..'Z').each{|x| LITERALS_LOOKUP[x]      = :parse_domain_literal    }
             [':'].each{|x| LITERALS_LOOKUP[x]      = :parse_symbol_literal    }
        ['"', "'"].each{|x| LITERALS_LOOKUP[x]      = :parse_string_literal    }
             ['/'].each{|x| LITERALS_LOOKUP[x]      = :parse_regexp_literal    }
             ['{'].each{|x| LITERALS_LOOKUP[x]      = :parse_args_literal      }
        
        
        def parse_literal
          method = LITERALS_LOOKUP[current_char]
          if method
            #puts "Starting reading a #{method} on #{current_char}"
            x = self.send(method)
            #puts "Read a #{x} now #{current_char} "
            x
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
          literal_node(resolve_domain(parse_regexp(DOMAIN_REGEXP, "domain")))
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

        def parse_args_literal
          parse_string('{-', true)
          names, values = [], []
          while (char = current_char) != '-'
            name, value = parse_arg_literal
            names << name
            values << value
            eat_spaces
            if current_char == ','
              @index += 1
              eat_spaces
            end
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