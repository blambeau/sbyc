class SByC::R::DomainGenerator::Builtin
  module OperatorDomain
    module ClassMethods
      
      def exemplars
        [ '(Operator (Heading :who String) String &(concat ["hello " who]))' ].collect{|src|
          system.evaluate(system.parse(src))
        }
      end
    
      def is_value?(value)
        value.class == self
      end

      def parse_literal(str)
        __not_a_literal__!(self, str)
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
      include SByC::R::Callable::SignatureBased
      
      attr_reader :heading
      attr_reader :returns
      attr_reader :expression
      
      def initialize(heading, returns, expression)
        @heading, @returns, @expression = heading, returns, expression
      end
      
      def call_signature(runner, args, binding)
        @call_signature ||= heading.to_call_signature(runner, args, binding)
      end
      
      def coerce(runner, args, binding)
        runner.make_call(expression, [], heading.to_binding(runner, args, binding))
      end
      
      def to_s
        "(Operator #{heading} #{returns.to_s} #{expression})"
      end
      
    end # module InstanceMethods
  end # module Operator
end # class SByC::R::DomainGenerator::Builtin