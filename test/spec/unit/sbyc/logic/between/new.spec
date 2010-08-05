require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::Between::new" do
  
  subject{ Logic::Between.new(:hello, interval) }
  
  describe "when interval is empty" do
    let(:interval){ Interval.empty }
    it{ should == Logic::NONE }
  end
  
  describe "when interval is all" do
    let(:interval){ Interval.all }
    it{ should == Logic::ALL }
  end
  
  describe "when interval is arbitrar" do
    let(:interval){ Interval.natural(0,20) }
    specify{ subject.interval.should == Interval.natural(0,20) }
  end
  
end
