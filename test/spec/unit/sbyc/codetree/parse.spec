require File.expand_path('../../../../spec_helper', __FILE__)
describe "CodeTree::parse" do
  
  let(:code)     { lambda { 
    (puts (to_s x)) 
    (say "hello")
  } }
  let(:expected){ ["(puts (to_s (? (_ :x))))", '(say (_ "hello"))'] }

  context "when called with a multiline option and proc as first" do
    subject { CodeTree::parse(code, :multiline => true) }
    specify{
      subject.collect{|s| s.inspect}.should == expected
    }
  end

  context "when called with a multiline option and proc as block, with nil as first" do
    subject { CodeTree::parse(nil, :multiline => true, &code) }
    specify{
      subject.collect{|s| s.inspect}.should == expected
    }
  end
  
  context "when called with a multiline option and proc as block, and nothing as first" do
    subject { CodeTree::parse(:multiline => true, &code) }
    specify{
      subject.collect{|s| s.inspect}.should == expected
    }
  end
  
  context "when called with an array of hashes as parameter" do
    subject{ CodeTree::parse{
      insert [{:id => 1}, {:id => 2}]
    }}
    specify{
      subject.should be_kind_of(CodeTree::AstNode)
      subject.name.should == :insert
      subject.children[0].should be_kind_of(CodeTree::AstNode)
      subject.children[0].literal.should == [{:id => 1}, {:id => 2}]
    }
  end
  
  context "when called with an array of hashes as parameter" do
    subject{ CodeTree::parse{
      (key! :table_name, [:col1, :col2])
    }}
    specify{
      subject.should be_kind_of(CodeTree::AstNode)
      subject.name.should == :key!
      subject.children[0].should be_kind_of(CodeTree::AstNode)
      subject.children[0].literal.should == :table_name
      subject.children[1].should be_kind_of(CodeTree::AstNode)
      subject.children[1].leaf?.should be_true
      subject.children[1].literal.should == [:col1, :col2]
    }
  end
  
end
  
