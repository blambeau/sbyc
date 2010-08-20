class SByC::R::DomainGenerator::Builtin
  module OperatorDomain
    module ClassMethods
      
      def exemplars
        [  ]
      end
    
      def is_value?(value)
        value.class == self
      end

      def parse_literal(str)
        raise NotImplementedError
      end

      def to_literal(value)
        value.to_s
      end
    
      def call_signature(runner, args, binding)
        @call_signature ||= [ [ runner.fed(:Heading)    ], 
                              [ runner.fed(:Domain)     ],
                              [ runner.fed(:Expression) ] ]
      end
    
      def coerce(runner, args, binding)
        self.new(*args)
      end

    end # module ClassMethods
    module InstanceMethods
      
      attr_reader :heading
      attr_reader :returns
      attr_reader :expression
      
      def initialize(heading, returns, expression)
        @heading, @returns, @expression = heading, returns, expression
      end
      
      def sbyc_call(runner, args, binding)
        b = heading.to_binding(runner, args, binding)
        expression.sbyc_call(runner, [], b)
      end
      
      def to_s
        "(Operator #{heading} #{expression})"
      end
      
    end # module InstanceMethods
  end # module Operator
end # class SByC::R::DomainGenerator::Builtin