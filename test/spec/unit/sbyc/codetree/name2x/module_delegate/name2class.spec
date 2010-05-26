require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Name2X::ModuleDelegate#name2class" do

  let(:delegate){ CodeTree::Name2X::ModuleDelegate.new(CodeTree) }

  describe "when called on some valid capitalized target" do
    subject{ delegate.name2class(:AstNode) }
    it { should == CodeTree::AstNode }
  end
 
  describe "when called on some valid non-capitalized target" do
    subject{ delegate.name2class(:astNode) }
    it { should == CodeTree::AstNode }
  end
 
  describe "when called on some valid non-capitalized target with underscores" do
    subject{ delegate.name2class(:ast_node) }
    it { should == CodeTree::AstNode }
  end
   
  describe "when called with no such target" do
    subject{ delegate.name2module(:nosuchone) }
    it { should be_nil }
  end

end