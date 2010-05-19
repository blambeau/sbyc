require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Rewriting::Rewriter#copy" do
  
  let(:engine) { CodeTree::rewriter }
  
  context "when called with a literal" do 
    subject{ engine.node(:test, [ 12 ]) }
    it { should == CodeTree::parse{ (test 12) } }
  end
  
  context "when called with copy in mind" do
    let(:node) { CodeTree::parse{ 12 } } 
    subject{ engine.node(node.function, node.children) }
    it { should == CodeTree::parse{ 12 } }
  end
  
end

