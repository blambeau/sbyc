require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::Any#eq" do
  
  let(:left) { factory::any(:hello) }
  let(:factory){ Logic::Finite }
  subject{ left == right }
  
  describe "Any == Any" do
    let(:right) { factory::any(:hello) }
    it{ should == true }
  end
  
  describe "Any == None" do
    let(:right) { factory::none(:hello) }
    it{ should == false }
  end
  
  describe "Any == other Any" do
    let(:right) { factory::any(:hello2) }
    it{ should == false }
  end
  
end