require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#functional_compile" do
  
  context('when called on a leaf node') do
    let(:node) { CodeTree::expr{ 12 } }
    subject{ node.functional_compile }
    it { should == "12" }
  end
  
  context('when called on a ?') do
    let(:node) { CodeTree::expr{ x } }
    subject{ node.functional_compile }
    it { should == "scope[:x]" }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { CodeTree::expr{ (say x, "Hello") } }
    subject{ node.functional_compile }
    it { should == 'receiver.say(scope[:x], "Hello")' }
  end
  
  context('when called with specific arguments') do
    let(:node)   { CodeTree::expr{ (say x, "Hello") } }
    subject{ node.functional_compile('r', 'hash', 'get') }
    it { should == 'r.say(hash.get(:x), "Hello")' }
  end
  
end
  
