module SByC
  module CodeTree
    class BasicObject
      
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
      
    end # class BasicObject
  end # module CodeTree
end # module SByC