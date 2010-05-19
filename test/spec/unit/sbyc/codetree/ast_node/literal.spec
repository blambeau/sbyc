require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#literal" do
  
  context "when called on a leaf node" do
    subject{ ::SByC::parse{ 12 }.literal }
    it { should == 12 }
  end
  
  context "when called on a branch node" do
    subject{ ::SByC::parse{ ~(~(12)) }.literal }
    it { should == 12 }
  end
  
end