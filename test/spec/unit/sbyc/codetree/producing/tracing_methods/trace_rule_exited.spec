require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Producing::TracingMethods#trace_rule_exited" do
  
  let(:tracer) { 
    t = Object.new.extend(CodeTree::Producing::TracingMethods) 
    def t.tracing_options 
      @options ||= CodeTree::Producing::TracingMethods.prepare_options(:io => [])
    end
    t
  }
  
  it "Should increment the indent level" do
    bef = tracer.tracing_indent_level
    tracer.trace_rule_exited("A message")
    aft = tracer.tracing_indent_level
    aft.should == bef-1
  end
  
  it "Should log the message" do
    tracer.trace_rule_exited("A message")
    tracer.tracing_io.should == ["A message\n"]
  end
  
end