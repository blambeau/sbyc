require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#coerce" do
  
  context("with a literal") do
    subject { CodeTree::AstNode.coerce(12) }
  
    it { should be_kind_of(CodeTree::AstNode) }
    
    specify { 
      subject.literal.should == 12 
      subject.children.should == [ 12 ]
      subject.to_s.should == "12"
      subject.inspect.should == "(_ 12)"
    }
  end
  
  context("with a literal in array form") do
    subject { CodeTree::AstNode.coerce([:_, [ 12 ]]) }
    it { should be_kind_of(CodeTree::AstNode) }
    specify { subject.inspect.should == "(_ 12)" }
  end
  
  context("without children") do
    subject { CodeTree::AstNode.coerce([:plus, []]) }
  
    it { should be_kind_of(CodeTree::AstNode) }
  
    specify { 
      subject.name.should == :plus 
      subject.children.should be_empty
    }
  end
  
  context("with literal children") do
    subject { CodeTree::AstNode.coerce([ :plus, [ 12, 15 ] ]) }
  
    it { should be_kind_of(CodeTree::AstNode) }
  
    specify { 
      subject.name.should == :plus 
      subject.children.collect{|a| a.literal}.should == [ 12, 15 ]
    }
  end
  
  context("with complex structure") do
    subject { CodeTree::AstNode.coerce([ :plus, [ [ :minus, [12, 15] ] ] ]) }
  
    it { should be_kind_of(CodeTree::AstNode) }
    
    specify {
      subject.name.should == :plus
      subject.children.size.should == 1
      subject.children[0].name.should == :minus
      subject.children[0].children.should be_kind_of(Array)
      subject.children[0].children.collect{|a| a.literal}.should == [12, 15]
    }
  end
  
  context("with array a single literal") do
    subject { CodeTree::AstNode.coerce([{:id => 1}, {:id => 2}]) }
    specify { 
      subject.should be_kind_of(CodeTree::AstNode) 
      subject.leaf?.should be_true
      subject.literal.should == [{:id => 1}, {:id => 2}]
    }
  end
  
end 