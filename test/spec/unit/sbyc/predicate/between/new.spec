require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::Between::new" do
  
  subject{ Predicate::Between.new(:hello, interval) }
  
  describe "when interval is empty" do
    let(:interval){ Interval.empty }
    it{ should == Predicate::NONE }
  end
  
  describe "when interval is all" do
    let(:interval){ Interval.all }
    it{ should == Predicate::ALL }
  end
  
  describe "when interval is arbitrar" do
    let(:interval){ Interval.natural(0,20) }
    specify{ subject.interval.should == Interval.natural(0,20) }
  end
  
end
