module CodeTree
  module Producing
    module TracingMethods
      
      # Default options
      DEFAULT_OPTIONS = {
        :indent_support  => true,
        :indent_string   => "  ",
        :newline_support => true,
        :io              => STDOUT
      }
      
      # Returns tracing extension options
      def tracing_options
        extension_options[TracingMethods] ||= {}
      end
      
      # Is indentation support installed?
      def tracing_indent_support?
        !!tracing_options[:indent_support]
      end
      
      # Is new line support installed?
      def tracing_newline_support?
        !!tracing_options[:newline_support]
      end
      
      # Returns the string to use for indentation
      def tracing_indent_string
        tracing_options[:indent_string] ||= "  "
      end
      
      # Returns the current indentation level
      def tracing_indent_level
        tracing_options[:indent_level] ||= 0
      end
      
      # Returns the IO object (actually, any object supporting the << operator)
      # that must be used for tracing the Producer.
      def tracing_io
        tracing_options[:io] ||= STDOUT
      end
      
      # Logs a message on the IO object, without any other side effect (no
      # depth increment, for instance).
      def trace(message)
        message = (tracing_indent_string*tracing_indent_level + message.to_s) if tracing_indent_support?
        message = "#{message}\n" if tracing_newline_support?
        if tracing_io.kind_of?(IO)
          tracing_io << message
        else
          tracing_io << message
        end
      end
      
      # Logs that a rule has been entered and increment the depth
      # level
      def trace_rule_entered(message)
        trace(message)
        tracing_options[:indent_level] = tracing_indent_level+1
      end
      
      # Logs that a rule has been exited and decrements the depth 
      # level
      def trace_rule_exited(message)
        tracing_options[:indent_level] = tracing_indent_level-1
        trace(message)
      end
      
    end # module TracingMethods
  end # module Producing
end # module CodeTree