require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Ordered::None#eq" do
  
  let(:left) { factory::none(:hello) }
  let(:factory){ Logic::Ordered }
  subject{ left == right }
  
  describe "None == None" do
    let(:right) { factory::none(:hello) }
    it{ should == true }
  end
  
  describe "None == Any" do
    let(:right) { factory::any(:hello) }
    it{ should == false }
  end
  
  describe "None == other None" do
    let(:right) { factory::none(:hello2) }
    it{ should == false }
  end
  
end