require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#object_compile" do
  
  context('when called on a leaf node, through coercion') do
    let(:node) { CodeTree::expr{ 12 } }
    subject{ node.object_compile }
    it { should == "12" }
  end
  
  context('when called on a ?') do
    let(:node) { CodeTree::expr{ x } }
    subject{ node.object_compile }
    it { should == "scope[:x]" }
  end
  
  context('when called on an expression') do
    let(:node) { CodeTree::expr{ x + z } }
    subject{ node.object_compile }
    it { should == "scope[:x].+(scope[:z])" }
  end
  
  context('when called on a object-like expression') do
    let(:node) { CodeTree::expr{ x.say_hello } }
    subject{ node.object_compile }
    it { should == "scope[:x].say_hello()" }
  end
  
  context('when called with specific arguments') do
    let(:node) { CodeTree::expr{ x.say_hello } }
    subject{ node.object_compile('hash', :get) }
    it { should == "hash.get(:x).say_hello()"}
  end
  
end
  
