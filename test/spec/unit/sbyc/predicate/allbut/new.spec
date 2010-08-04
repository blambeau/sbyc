require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::AllBut::new" do
  
  subject{ Predicate::AllBut.new(:hello, values) }
  
  describe "when values are empty" do
    let(:values){ [] }
    it{ should == Predicate::ALL }
  end
  
  describe "when values are not empty" do
    let(:values){ [:x] }
    it{ should be_kind_of(Predicate::AllBut) }
    specify{ subject.values.should == [:x] }
  end
  
  describe "when values contain duplicates" do
    let(:values){ [:x, :y, :x] }
    specify{ subject.values.should == [:x, :y] }
  end
  
end
