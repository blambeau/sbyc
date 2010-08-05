require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Ordered::Ranged#boot_and" do
  
  let(:factory){ Logic::Ordered }
  subject{ left.bool_and(right) }
  
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
    it{ should == left }
  end
  
  describe "on disjoint intervals" do
    let(:left){ factory::lt(:x, 0) }
    let(:right){ factory::gt(:x, 20) }
    it{ should == factory.ranged(:x, Interval.empty) }
    it{ should == factory.none(:x) }
  end
  
  describe "on overlapping intervals" do
    let(:left){ factory::gt(:x, 0) }
    let(:right){ factory::gt(:x, 20) }
    it{ should == factory.ranged(:x, Interval.gt(20)) }
  end
  
end
  
