require File.expand_path('../../../spec_helper', __FILE__)
describe "R::Boolean.to_literal" do
  
  subject{ R::Boolean::to_literal(value) }
  
  describe "when called on true" do
    let(:value){ true }
    it{ should == 'true' }
  end
  
  describe "when called on false" do
    let(:value){ false }
    it{ should == 'false' }
  end
  
end