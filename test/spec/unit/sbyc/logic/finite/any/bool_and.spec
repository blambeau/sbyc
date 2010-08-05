require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::Any::bool_and" do
  
  let(:factory){ Logic::Finite }
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
  
  describe "Any & AllBut -> AllBut" do
    let(:right){ factory::allbut(:hello, [:x]) }
    it{ should == right }
  end
  
end