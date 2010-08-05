require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Ordered::Any::bool_or" do
  
  let(:factory){ Logic::Ordered }
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
  
  describe "Any | Ranged -> Any" do
    let(:right){ factory::lt(:hello, 12) }
    it{ should == left }
  end
  
end