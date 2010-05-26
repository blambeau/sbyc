require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Name2X::Delegate#name2name" do

  let(:hash){ {:to_name   => :name, 
               :to_module => CodeTree, 
               :to_class  => CodeTree::AstNode} }

  let(:delegate){ CodeTree::Name2X::Delegate.new(hash) }

  describe "when called with a target module" do
    subject{ delegate.name2name(:to_module) }
    it { should be_nil }
  end
 
  describe "when called with a target class" do
    subject{ delegate.name2name(:to_class) }
    it { should be_nil }
  end
 
  describe "when called with a target Symbol" do
    subject{ delegate.name2name(:to_name) }
    it { should == :name }
  end
 
  describe "when called on unexisting" do
    subject{ delegate.name2name(:not_exists) }
    it { should be_nil }
  end
 
end