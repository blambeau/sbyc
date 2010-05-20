require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#object_eval" do
  
  context('when called on a leaf node, through coercion') do
    let(:node) { CodeTree::expr{ 12 } }
    subject{ node.object_eval }
    it { should == 12 }
  end
  
  context('when called on a ?') do
    let(:node) { CodeTree::expr{ x } }
    subject{ node.object_eval(:x => 12) }
    it { should == 12 }
  end
  
  context('when called on an expression') do
    let(:node) { CodeTree::expr{ x + z } }
    subject{ node.object_eval(:x => 12, :z => 15) }
    it { should == 27 }
  end
  
  context('when called on a object-like expression') do
    let(:node) { CodeTree::expr{ x.say_hello } }
    let(:twel) { x = Object.new; def x.say_hello(); "hello"; end; x}
    subject{ node.object_eval(:x => twel) }
    it { should == "hello" }
  end
  
  context('when called on a object-like expression and specific scope method') do
    let(:node) { CodeTree::expr{ x.say_hello } }
    let(:twel) { x = Object.new; def x.say_hello(); "hello"; end; x}
    subject{ node.object_eval({:x => twel}, :fetch) }
    it { should == "hello" }
  end
  
end
  
