require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#inspect" do
  
  subject{ node.inspect }

  context('when called on a leaf node') do
    let(:node) { ::SByC::CodeTree::LeafNode.new(12) }
    it { should == "(__literal__ 12)" }
  end
  
  context('when called on a leaf node, through coercion') do
    let(:node) { ::SByC::CodeTree::AstNode.coerce(12) }
    it { should == "(__literal__ 12)" }
  end
  
  context('when called on a ?') do
    let(:node) { ::SByC::CodeTree::AstNode.coerce([:'?', [:x]]) }
    it { should == "(? (__literal__ :x))" }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { ::SByC::parse{ (say x, "SByC") } }
    it { subject.should == '(say (? (__literal__ :x)), (__literal__ "SByC"))' }
  end
  
end
  
