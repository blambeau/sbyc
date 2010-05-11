require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#object_apply" do
  
  context('when called on a leaf node') do
    let(:node) { ::SByC::CodeTree::LeafNode.new(12) }
    subject{ node.object_eval }
    it { should == 12 }
  end
  
  context('when called on a leaf node, through coercion') do
    let(:node) { ::SByC::CodeTree::AstNode.coerce(12) }
    subject{ node.object_eval }
    it { should == 12 }
  end
  
  context('when called on a __scope_get__') do
    let(:node) { ::SByC::CodeTree::AstNode.coerce([:__scope_get__, [:x]]) }
    subject{ node.object_eval(:x => 12) }
    it { should == 12 }
  end
  
  context('when called on an expression') do
    let(:node) { ::SByC::parse{ x + z } }
    subject{ node.object_eval(:x => 12, :z => 15) }
    it { should == 27 }
  end
  
  context('when called on a object-like expression') do
    let(:node) { ::SByC::parse{ x.say_hello } }
    let(:twel) { x = Object.new; def x.say_hello(); "hello"; end; x}
    subject{ node.object_eval(:x => twel) }
    it { should == "hello" }
  end
  
end
  
