require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Ordered::bool_and" do
  
  let(:factory){ Logic::Ordered }
  let(:left) { factory::any(:hello) }
  subject{ left.bool_and(right) }
  
  describe "Any & Any -> Any" do
    let(:right){ factory::any(:hello) }
    it{ should == left }
  end
  
  describe "Any & None -> None" do
    let(:right){ factory::none(:hello) }
    it{ should == right }
  end
  
  describe "Any & Ranged -> Ranged" do
    let(:right){ factory::lt(:hello, 12) }
    it{ should == right }
  end
  
end