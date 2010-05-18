require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Matching::Matcher#match" do
  
  context "when called on something that matches" do
    let(:matcher) { SByC::matcher{ (match :say, x) } }
    let(:matched) { SByC::parse  { (say "hello")   } }
    subject{ matcher =~ matched }
    it { should_not be_nil }
    specify{ subject[:x].should == SByC::parse{"hello"} }
  end
  
  context "when called on something that does not match" do
    let(:matcher) { SByC::matcher{ (match :say, x) } }
    let(:matched) { SByC::parse  { (nosay "hello") } }
    subject{ matcher =~ matched }
    it { should be_nil }
  end
  
end

