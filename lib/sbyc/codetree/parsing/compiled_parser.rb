module Anagram
  module Parsing
    class CompiledParser
    
      # Creates a parser instance
      def initialize()
        @regexps = Hash.new {|hash,key| hash[key] = Regexp.new(key)}
        @memoization = nil
        @terminal_parse_failures = nil
      end
    
      # Parses a given source
      def parse(source, rule=nil)
        rule = root unless rule
        raise ArgumentError, "Rule is nil and not root has been installed" unless rule
        source.extend(Anagram::Utils::StringUtils)
        @memoization = {}
        r0 = factor_result(source, 0, 0)
        r1 = self.send("_nt_#{rule}", r0)
        raise ParseError, failure_reason(source) unless r1
        raise ParseError, failure_reason(source, r1) unless r1.stop_index==source.length
        r1
      end
      
      # Adds a terminal parse failure
      def terminal_parse_failure(r0, terminal)
        stop_index = r0.stop_index
        return nil if @terminal_parse_failures and @terminal_parse_failures[0]>stop_index
        @terminal_parse_failures = [stop_index] if @terminal_parse_failures.nil? or
                                                @terminal_parse_failures[0]<stop_index
        @terminal_parse_failures << terminal
        nil
      end
      
      # Get a user-friendly failure reason
      def failure_reason(source, rend=nil)
        return "Nothing parsed." unless @terminal_parse_failures
        reason, index = "Expected one of ", @terminal_parse_failures[0]
        @terminal_parse_failures.uniq.each_with_index do |fail,i|
          next if i==0
          reason << ', ' unless i==1
          reason << "'#{fail}'"
        end
        reason << " at #{index}, " << source.line_of(index).to_s << "::" << source.column_of(index).to_s
        if rend
          reason << "\ntrailing source were\n'"
          reason << source[rend.stop_index..-1].to_s
          reason << "'"
        end
      end
    
      # Checks in memorization
      def already_found?(r, rule)
        return nil unless @memoization[rule]
        @memoization[rule][r.stop_index]
      end
      
      # Memoizes a given result
      def memoize(r, rule, result)
        @memoization[rule] = {} unless @memoization[rule]
        @memoization[rule][r.stop_index] = result
      end
      
      # Factors an empty result
      def empty(r0)
        source, stop_index = r0.source, r0.stop_index
        factor_result(source, stop_index, stop_index)
      end
    
      # Parses any character
      def anything(r0)
        source, stop_index = r0.source, r0.stop_index
        unless stop_index+1 > source.length
          factor_result(source, stop_index, stop_index+1)
        else
          terminal_parse_failure(r0, '.')
        end
      end
    
      # Parses the terminal _which_ in the state _r0_
      def terminal(r0, which)
        source, stop_index = r0.source, r0.stop_index
        return factor_result(source, stop_index, stop_index+which.length)\
          if source.index(which, stop_index)==stop_index
        terminal_parse_failure(r0, which)
      end
  
      # Parses the regular expression _which_ in the state _r0_
      def regexp(r0, which)
        source, stop_index = r0.source, r0.stop_index
        return factor_result(source, stop_index, stop_index+$&.length) \
          if source.index(@regexps[which],stop_index)==stop_index
        terminal_parse_failure(r0, which)
      end
    
      # Checks an optional
      def optional(r0, result)
        result ? result : empty(r0)
      end
    
      # Positive look ahead
      def positive_lookahead?(r0, result)
        result ? empty(r0) : nil
      end
    
      # Negative look ahead
      def negative_lookahead?(r0, result)
        result ? nil : empty(r0)
      end
    
      # ZeroOrMore macro (corresponding to '*')
      def zero_or_more(r0) 
        acc, r1 = [], r0
        while r1 = yield(r1)
          acc << r1
        end
        accumulate(r0, nil, acc)
      end  
    
      # OneOrMore macro (corresponding to '+')
      def one_or_more(r0) 
        acc, r1 = [yield(r0)], r0
        return nil unless acc.last
        while r1 = yield(r1)
          acc << r1
        end
        accumulate(r0, nil, acc)
      end
    
    end # class CompiledParser
  end # module Parsing
end # module Anagram