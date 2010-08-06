require File.expand_path('../../../spec_helper', __FILE__)
describe "R::String.is_value?" do
  
  subject{ R::String.is_value?(value) }
  
  describe "when called on a string" do
    let(:value){ 'hello' }
    it{ should == true }
  end
  
  describe "when called on nil" do
    let(:value){ nil }
    it{ should == false }
  end
  
end
