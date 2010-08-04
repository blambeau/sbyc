require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::Between#==" do
  
  subject{ left == right }
  
  describe "when intervals are empty and same name" do
    let(:left){  Predicate::Between.new(:hello, Interval.empty) }
    let(:right){ Predicate::Between.new(:hello, Interval.empty) }
    it{ should == true }
  end
  
  describe "when intervals are empty and not same name" do
    let(:left){  Predicate::Between.new(:hello, Interval.empty) }
    let(:right){ Predicate::Between.new(:hello2, Interval.empty) }
    it{ should == true }
  end
  
  describe "when intervals are all and same name" do
    let(:left){  Predicate::Between.new(:hello, Interval.all) }
    let(:right){ Predicate::Between.new(:hello, Interval.all) }
    it{ should == true }
  end
  
  describe "when intervals are all and not same name" do
    let(:left){  Predicate::Between.new(:hello, Interval.all) }
    let(:right){ Predicate::Between.new(:hello2, Interval.all) }
    it{ should == true }
  end
  
  describe "when intervals are equal but not same name" do
    let(:left){  Predicate::Between.new(:hello, Interval.point(5)) }
    let(:right){ Predicate::Between.new(:hello2, Interval.point(5)) }
    it{ should == false }
  end
  
  describe "when intervals are equal and same name" do
    let(:left){  Predicate::Between.new(:hello, Interval.point(5)) }
    let(:right){ Predicate::Between.new(:hello, Interval.point(5)) }
    it{ should == true }
  end
  
  describe "when intervals are not equal and same name" do
    let(:left){  Predicate::Between.new(:hello, Interval.point(5)) }
    let(:right){ Predicate::Between.new(:hello, Interval.point(6)) }
    it{ should == false }
  end
  
  describe "when intervals are not equal and not same name" do
    let(:left){  Predicate::Between.new(:hello, Interval.point(5)) }
    let(:right){ Predicate::Between.new(:hello2, Interval.point(6)) }
    it{ should == false }
  end
  
end
