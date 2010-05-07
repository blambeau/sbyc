require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#coerce" do
  
  context("with a literal") do
    subject { ::SByC::CodeTree::AstNode.coerce(12) }
  
    it { should be_kind_of(::SByC::CodeTree::LeafNode) }
    
    specify { 
      subject.literal.should == 12 
      subject.children.should == []
      subject.lambda.should be_nil
      subject.to_s.should == "(literal 12)"
    }
  end
  
  context("without children") do
    subject { ::SByC::CodeTree::AstNode.coerce([:plus, []]) }
  
    it { should be_kind_of(::SByC::CodeTree::AstNode) }
  
    specify { 
      subject.name.should == :plus 
      subject.children.should be_empty
      subject.lambda.should be_nil
    }
  end
  
  context("with literal children") do
    subject { ::SByC::CodeTree::AstNode.coerce([ :plus, [ 12, 15 ] ]) }
  
    it { should be_kind_of(::SByC::CodeTree::AstNode) }
  
    specify { 
      subject.name.should == :plus 
      subject.children.collect{|a| a.literal}.should == [ 12, 15 ]
      subject.lambda.should be_nil
    }
  end
  
  context("with complex structure") do
    subject { ::SByC::CodeTree::AstNode.coerce([ :plus, [ [ :minus, [12, 15] ] ] ]) }
  
    it { should be_kind_of(::SByC::CodeTree::AstNode) }
    
    specify {
      subject.name.should == :plus
      subject.children.size.should == 1
      subject.children[0].name.should == :minus
      subject.children[0].children.should be_kind_of(Array)
      subject.children[0].children.collect{|a| a.literal}.should == [12, 15]
    }
  end
  
end 