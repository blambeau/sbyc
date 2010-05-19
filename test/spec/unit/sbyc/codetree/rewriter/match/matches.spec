require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Rewriting::Rewriter::Match#matches?" do
  
  let(:branch)  { CodeTree::AstNode.new(:branch, [1, 2, 3]) }
  let(:literal) { CodeTree::AstNode.coerce(12) }
  
  context "when built with a symbol" do
    subject { CodeTree::Rewriting::Rewriter::Match.coerce(:_, nil) }
    specify { 
      (subject.matches? branch).should be_false
      (subject.matches? literal).should be_true
      (subject === branch).should be_false
      (subject === literal).should be_true
    }
  end
  
  context "when built with a proc" do
    let(:proc) { lambda {|node| node.name == :branch } }
    subject { CodeTree::Rewriting::Rewriter::Match.coerce(proc, nil) }
    specify { 
      (subject.matches? branch).should be_true
      (subject.matches? literal).should be_false
    }
  end
  
end