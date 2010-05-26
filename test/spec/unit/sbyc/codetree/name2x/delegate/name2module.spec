require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Name2X::Delegate#name2module" do

  let(:hash){ {:to_name   => :name, 
               :to_module => CodeTree, 
               :to_class  => CodeTree::AstNode} }

  let(:delegate){ CodeTree::Name2X::Delegate.new(hash) }

  describe "when called with a target module" do
    subject{ delegate.name2module(:to_module) }
    it { should == CodeTree }
  end
 
  describe "when called with a target module, through a class" do
    subject{ delegate.name2module(:to_class) }
    it { should == CodeTree::AstNode }
  end
 
  describe "when called on something else" do
    subject{ delegate.name2module(:to_name) }
    it { should be_nil }
  end
 
  describe "when called on unexisting" do
    subject{ delegate.name2module(:not_exists) }
    it { should be_nil }
  end
 
end