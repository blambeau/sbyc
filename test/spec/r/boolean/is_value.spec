require File.expand_path('../../../spec_helper', __FILE__)
describe "R::Boolean.is_value?" do
  
  subject{ R::Boolean.is_value?(value) }
  
  describe "when called on false" do
    let(:value){ false }
    it{ should == true }
  end
  
  describe "when called on true" do
    let(:value){ true }
    it{ should == true }
  end
  
  describe "when called on nil" do
    let(:value){ nil }
    it{ should == false }
  end
  
end
