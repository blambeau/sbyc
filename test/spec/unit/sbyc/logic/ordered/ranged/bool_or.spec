require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Ordered::Ranged#boot_or" do
  
  let(:factory){ Logic::Ordered }
  subject{ left.bool_or(right) }
  
  describe "on an empty interval" do
    let(:left){ factory::ranged(:x, Interval.empty) }
    let(:right){ factory::ranged(:x, Interval.empty) }
    it{ should == left }
  end
  
  describe "on an full interval" do
    let(:left){ factory::ranged(:x, Interval.all) }
    let(:right){ factory::ranged(:x, Interval.all) }
    it{ should == left }
  end
  
  describe "on empty vs. full" do
    let(:left){ factory::ranged(:x, Interval.empty) }
    let(:right){ factory::ranged(:x, Interval.all) }
    it{ should == right }
  end
  
  describe "on disjoint intervals" do
    let(:left){ factory::lt(:x, 0) }
    let(:right){ factory::gt(:x, 20) }
    it{ should == factory.ranged(:x, Interval.lt(0) + Interval.gt(20)) }
  end

  describe "on overlapping intervals" do
    let(:left){ factory::gt(:x, 0) }
    let(:right){ factory::gt(:x, 20) }
    it{ should == factory.ranged(:x, Interval.gt(0)) }
  end
  
  describe "on touching intervals" do
    let(:left){ factory::gt(:x, 0) }
    let(:right){ factory::lte(:x, 20) }
    it{ should == factory.ranged(:x, Interval.all) }
    it{ should == factory.any(:x) }
  end
  
end
  
