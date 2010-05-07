require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::System::Operator#to_ruby_code" do
  
  context "without arguments" do
    let(:signature) { ::SByC::System::Signature.coerce([]) }
    let(:operator)  { ::SByC::System::Operator.new(:hello, signature, String, "hello".inspect) }
    subject { operator.to_ruby_code }
    it { should == '"hello"' }
  end
  
  context "with one argument" do
    let(:signature) { ::SByC::System::Signature.coerce([Integer]) }
    let(:operator)  { ::SByC::System::Operator.new(:hello, signature, Integer, "$0.+(1)") }
    subject { operator.to_ruby_code(nil, [17.inspect]) }
    it { should == '17.+(1)' }
  end

  context "with two arguments" do
    let(:signature) { ::SByC::System::Signature.coerce([Integer, Integer]) }
    let(:operator)  { ::SByC::System::Operator.new(:hello, signature, Integer, "$0.+($1)") }
    subject { operator.to_ruby_code(nil, [17.inspect, 20.inspect]) }
    it { should == '17.+(20)' }
  end
  
end