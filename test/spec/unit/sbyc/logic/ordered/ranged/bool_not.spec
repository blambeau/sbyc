require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Ordered::Ranged#boot_not" do
  
  let(:factory){ Logic::Ordered }
  subject{ left.bool_not }
  
  describe "On an empty interval" do
    let(:left){ factory::ranged(:var, Interval.empty) }
    it{ should == factory::ranged(:var, Interval.all) }
  end
  
  describe "On an full interval" do
    let(:left){ factory::ranged(:var, Interval.all) }
    it{ should == factory::ranged(:var, Interval.empty) }
  end
  
  describe "On an specific point interval" do
    let(:left){ factory::ranged(:var, Interval.point(8)) }
    it{ should == factory::ranged(:var, Interval.point(8).complement) }
  end
  
  describe "On an specific interval" do
    let(:left){ factory::between(:var, 0, 20) }
    it{ should == factory::ranged(:var, Interval.lt(0) + Interval.gt(20)) }
  end
  
end