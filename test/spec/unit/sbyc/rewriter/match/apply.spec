require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Rewriter::Match#apply" do
  
  let(:predicate) { true }
  let(:block)     { lambda{ |r, *args| [r,args] } }
  subject { ::SByC::Rewriter::Match.new(predicate, block) }
  
  context "when called on a leaf node" do
    let(:node) { ::SByC::CodeTree::LeafNode.new(:literal) }
    specify { 
      subject.apply("rewriter", node).should == ["rewriter", [node]]
    }
  end
  
  context "when called on a branch node" do
    let(:node) { ::SByC::CodeTree::AstNode.new(:branch, [1, 2, 3], nil) }
    specify { 
      subject.apply("rewriter", node).should == ["rewriter", [1, 2, 3]]
    }
  end
  
end