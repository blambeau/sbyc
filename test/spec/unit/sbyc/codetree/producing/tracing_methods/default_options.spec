require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Producing::TracingMethods#default_options" do
  
  subject{ CodeTree::Producing::TracingMethods.default_options }
  
  it { should be_kind_of(Hash) }
  specify { subject[:io].should_not be_nil }
  
end