module SByC
  module R
    class Operators
    
      # Creates a collection instance  
      def initialize
        @operators = Hash.new{|h,k| h[k] = []}
      end
      
      # Find an operator that matches a given signature
      def find_operator(name, signature)
        if @operators.key?(name)
          @operators[name].find{|op| op.signature_matches?(signature)}
        else
          nil
        end
      end

      # Adds an operator
      def add_operator(names, op)
        names = [ names ] unless names.kind_of?(Array)
        names.each{|name| @operators[name] << op}
      end
      
      # Adds a monadic operator
      def wrap_operator(names, signature, returns, impl = nil)
        names = [ names ] unless names.kind_of?(Array)
        impl = names.last if impl.nil?
        add_operator(names, WrappedOperator.new(signature, returns, impl))
      end
      
      def aggregate_operator(names, operand_domain, neutral_value, impl = nil)
        names = [ names ] unless names.kind_of?(Array)
        impl = names.last if impl.nil?
        add_operator(names, AggregateOperator.new(operand_domain, neutral_value, impl))
      end
      
    end # class Operators
  end # module R
end # module SByC