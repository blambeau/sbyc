require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::Any::bool_or" do
  
  let(:factory){ Logic::Finite }
  let(:left) { factory::any(:hello) }
  subject{ left.bool_or(right) }
  
  describe "Any | Any -> Any" do
    let(:right){ factory::any(:hello) }
    it{ should == left }
  end
  
  describe "Any | None -> Any" do
    let(:right){ factory::none(:hello) }
    it{ should == left }
  end
  
  describe "Any | AllBut -> Any" do
    let(:right){ factory::allbut(:hello, [:x]) }
    it{ should == left }
  end
  
end