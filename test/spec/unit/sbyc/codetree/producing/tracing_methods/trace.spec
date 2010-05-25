require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Producing::TracingMethods#trace" do
  
  context("Without indentation support") do
    let(:tracer) {
      t = Object.new
      t.extend(CodeTree::Producing::TracingMethods)
      def t.tracing_options 
        @options ||= {:newline_support => false,
                      :indent_support  => false,
                      :indent_level    => 12,
                      :io              => []}
      end 
      t
    }
    specify {
      tracer.trace("This is a first message\n")
      tracer.tracing_io.should == ["This is a first message\n"]
    }
  end
  
  context("With indent support") do
    let(:tracer) {
      t = Object.new
      t.extend(CodeTree::Producing::TracingMethods)
      def t.tracing_options 
        @options ||= {:newline_support => false,
                      :indent_support  => true,
                      :indent_level    => 2,
                      :indent_string   => "aaa ",
                      :io              => []}
      end 
      t
    }
    specify {
      tracer.trace("This is a first message")
      tracer.tracing_io.should == ["aaa aaa This is a first message"]
    }
  end
  
  context("With newline support") do
    let(:tracer) {
      t = Object.new
      t.extend(CodeTree::Producing::TracingMethods)
      def t.tracing_options 
        @options ||= {:newline_support => true,
                      :indent_support  => false,
                      :io              => []}
      end 
      t
    }
    specify {
      tracer.trace("This is a first message")
      tracer.tracing_io.should == ["This is a first message\n"]
    }
  end
  
end