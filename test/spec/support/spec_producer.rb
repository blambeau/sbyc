module SByC
  module R
    class SpecRunner < SByC::CodeTree::Producing::Producer

      # Number of assertions
      attr_reader :assertion_count

      # Pending tests
      attr_reader :pending

      # Failures
      attr_reader :failures

      def initialize
        super(true)
        @assertion_count = 0
        @pending = []
        @failures = []

        rule(:pending) do |engine, node|
          @assertion_count += 1
          @pending << node[0]
        end

        rule(:should) do |engine, node|
          @assertion_count += 1
          begin
            @to_check = R::evaluate({}, node[0])
            ok, value = engine.apply(node[1])
            unless ok
              @failures << [node, value]
            end
          rescue StandardError => ex
            @failures << [node, ex.message]
          end
        end

        rule(:eq) do |engine, node|
          expected = engine.apply(node.children)[0]
          if @to_check == expected
            [true, expected]
          else
            [false, "Expected #{R::to_literal(expected)}, got #{R::to_literal(@to_check)}"]
          end
        end
      end

      # Runs on an expression
      def run(expr, &block)
        ast = CodeTree::coerce(expr || block, :multiline => true)
        apply(ast)
      end
      
      def has_failure?
        not(failures.empty?)
      end

      def to_s
        buffer = "#{assertion_count} assertions, #{failures.size} failures, #{pending.size} pending\n"
        unless failures.empty?
          buffer << "\nFailures:\n"
          failures.each{|code, msg|
            buffer << "\n" << code.to_s << "\n"
            buffer << msg << "\n"
          }
        end
        unless pending.empty?
          buffer << "\nPending:\n"
          pending.each{|code|
            buffer << "\n"
            buffer << "* " << code.to_s << "\n"
          }
        end
        buffer
      end
    
    end # SpecRunner
  end # module R
end # module SByC