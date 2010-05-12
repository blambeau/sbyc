require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#inspect" do
  
  subject{ node.to_s }

  context('when called on a leaf node') do
    let(:node) { ::SByC::CodeTree::LeafNode.new(12) }
    it { should == "12" }
  end
  
  context('when called on a leaf node, through coercion') do
    let(:node) { ::SByC::CodeTree::AstNode.coerce(12) }
    it { should == "12" }
  end
  
  context('when called on a __scope_get__') do
    let(:node) { ::SByC::CodeTree::AstNode.coerce([:__scope_get__, [:x]]) }
    it { should == "(__scope_get__ :x)" }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { ::SByC::parse{ (say x, "SByC") } }
    it { subject.should == '(say (__scope_get__ :x), "SByC")' }
  end
  
end
  
