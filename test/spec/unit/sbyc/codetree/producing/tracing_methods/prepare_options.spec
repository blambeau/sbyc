require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Producing::TracingMethods#prepare_options" do
  
  subject{ CodeTree::Producing::TracingMethods.prepare_options(options) }
  
  context "When called without options" do
    let(:options){ {} }
    it { should == CodeTree::Producing::TracingMethods.default_options }
    specify { subject[:io].should == STDOUT }
  end 
  
  context "When called with overriding option" do
    let(:options){ {:io => []} }
    specify { subject[:io].should == [] }
  end 
  
end