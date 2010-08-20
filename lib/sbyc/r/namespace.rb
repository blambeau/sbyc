module SByC
  module R
    class Namespace
      
      attr_reader :runner
      attr_reader :name
      
      # Creates a namespace instance
      def initialize(runner, name)
        @runner = runner
        @name = name
        @defs = {}
      end
      
      def each_pair(&block)
        @defs.each_pair(&block)
      end
      
      def knows?(name)
        @defs.key?(name)
      end
      
      def def(name, value)
        @defs[name] = value
        if value.respond_to?(:sbyc_name)
          value.sbyc_name = name
        end
        value
      end
      
      def fed(name)
        @defs[name]
      end
      
    end # class Namespace
  end # module R
end # module SByC