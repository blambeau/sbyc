require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#inspect" do
  
  subject{ node.to_s }

  context('when called on a leaf node, through coercion') do
    let(:node) { CodeTree::AstNode.coerce(12) }
    it { should == "12" }
  end
  
  context('when called on a ?') do
    let(:node) { CodeTree::AstNode.coerce([:'?', [:x]]) }
    it { should == "x" }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { CodeTree::parse{ (say x, "Hello") } }
    it { subject.should == '(say x, "Hello")' }
  end
  
end
  
