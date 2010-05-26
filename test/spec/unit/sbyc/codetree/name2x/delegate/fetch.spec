require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Name2X::Delegate#fetch" do

  let(:hash){ {:to_name => :name, 
               :to_module => CodeTree, 
               :to_class => Class.new} }

  let(:delegate){ CodeTree::Name2X::Delegate.new(hash) }

  subject{ delegate.fetch(:to_module) }
  
  it { should == CodeTree }
 
end