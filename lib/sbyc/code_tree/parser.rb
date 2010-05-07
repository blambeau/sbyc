module SByC
  module CodeTree
    class Parser
      
      # Methods that we keep
      KEPT_METHODS = [ "__send__", "__id__", "instance_eval", "initialize", "object_id", 
                       "singleton_method_added", "singleton_method_undefined", "method_missing",
                       "__evaluate__"]

      class << self
        def __clean_scope__
          # Removes all methods that are not needed to the class
          (instance_methods + private_instance_methods).each do |m|
            m_to_s = m.to_s
            undef_method(m_to_s.to_sym) unless ('__' == m_to_s[0..1]) or KEPT_METHODS.include?(m_to_s)
          end
        end
      end
      
      # Creates a Parser instance
      def initialize
        class << self
          __clean_scope__
        end
      end
      
      # When something is missing
      def method_missing(name, *args, &block)
        ::SByC::CodeTree::AstNode::coerce([name, args, block])
      end
      
      # Parses a block
      def self.parse(code = nil, &block)
        block = code || block
        case block
          when Proc
            Parser.new.instance_eval(&block)
          when String
            Parser.new.instance_eval(block)
          else
            raise ArgumentError, "Unable to parse #{block}"
        end
      end
      
    end # class Parser
  end # module CodeTree
end # module SByC