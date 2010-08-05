require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Ordered::None::bool_or" do
  
  let(:factory){ Logic::Ordered }
  let(:left) { factory::none(:hello) }
  subject{ left.bool_or(right) }
  
  describe "None | Any -> Any" do
    let(:right){ factory::any(:hello) }
    it{ should == right }
  end
  
  describe "None | None -> None" do
    let(:right){ factory::none(:hello) }
    it{ should == left }
  end
  
  describe "None | Ranged -> Ranged" do
    let(:right){ factory::lt(:hello, 12) }
    it{ should == right }
  end
  
end