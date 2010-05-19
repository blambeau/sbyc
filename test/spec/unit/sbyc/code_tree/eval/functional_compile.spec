require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#functional_compile" do
  
  context('when called on a leaf node') do
    let(:node) { ::SByC::expr{ 12 } }
    subject{ node.functional_compile }
    it { should == "12" }
  end
  
  context('when called on a ?') do
    let(:node) { ::SByC::expr{ x } }
    subject{ node.functional_compile }
    it { should == "scope[:x]" }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { ::SByC::expr{ (say x, "SByC") } }
    subject{ node.functional_compile }
    it { should == 'receiver.say(scope[:x], "SByC")' }
  end
  
  context('when called with specific arguments') do
    let(:node)   { ::SByC::expr{ (say x, "SByC") } }
    subject{ node.functional_compile('r', 'hash', 'get') }
    it { should == 'r.say(hash.get(:x), "SByC")' }
  end
  
end
  
