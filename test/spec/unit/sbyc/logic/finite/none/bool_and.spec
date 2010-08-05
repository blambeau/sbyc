require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::None::bool_and" do
  
  let(:factory){ Logic::Finite }
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
  
  describe "None & AllBut -> None" do
    let(:right){ factory::allbut(:hello, [:x]) }
    it{ should == left }
  end
  
end