require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Name2X::Delegate#name2class" do

  let(:hash){ {:to_name   => :name, 
               :to_module => CodeTree, 
               :to_class  => CodeTree::AstNode} }

  let(:delegate){ CodeTree::Name2X::Delegate.new(hash) }

  describe "when called with a target module" do
    subject{ delegate.name2class(:to_module) }
    it { should be_nil }
  end
 
  describe "when called with a target class" do
    subject{ delegate.name2class(:to_class) }
    it { should == CodeTree::AstNode }
  end
 
  describe "when called on something else" do
    subject{ delegate.name2class(:to_name) }
    it { should be_nil }
  end
 
  describe "when called on unexisting" do
    subject{ delegate.name2class(:not_exists) }
    it { should be_nil }
  end
 
end