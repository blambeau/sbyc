require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Rewriting::Rewriter::Match#apply" do
  
  let(:predicate) { true }
  let(:block)     { lambda{ |r, node, *args| [r, node, args] } }
  subject { CodeTree::Rewriting::Rewriter::Match.new(predicate, block) }
  
  context "when called on a leaf node" do
    let(:node) { CodeTree::AstNode.coerce(:literal) }
    specify { 
      subject.apply("rewriter", node).should == ["rewriter", node, [ :literal ]]
    }
  end
  
  context "when called on a branch node" do
    let(:node) { CodeTree::AstNode.new(:branch, [1, 2, 3]) }
    specify { 
      subject.apply("rewriter", node).should == ["rewriter", node, [1, 2, 3]]
    }
  end
  
end