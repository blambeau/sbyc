require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::None::bool_or" do
  
  let(:factory){ Logic::Finite }
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
  
  describe "None | AllBut -> AllBut" do
    let(:right){ factory::allbut(:hello, [:x]) }
    it{ should == right }
  end
  
end