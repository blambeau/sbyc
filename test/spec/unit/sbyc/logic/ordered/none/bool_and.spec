require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Ordered::None::bool_and" do
  
  let(:factory){ Logic::Ordered }
  let(:left) { factory::none(:hello) }
  subject{ left.bool_and(right) }
  
  describe "None & None -> None" do
    let(:right){ factory::none(:hello) }
    it{ should == left }
  end
  
  describe "None & Any -> None" do
    let(:right){ factory::any(:hello) }
    it{ should == left }
  end
  
  describe "None & Ranged -> None" do
    let(:right){ factory::lt(:hello, 12) }
    it{ should == left }
  end
  
end