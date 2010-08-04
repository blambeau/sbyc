require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::BelongsTo::new" do
  
  subject{ Predicate::BelongsTo.new(:hello, values) }
  
  describe "when values are empty" do
    let(:values){ [] }
    it{ should == Predicate::NONE }
  end
  
  describe "when values are not empty" do
    let(:values){ [:x] }
    it{ should be_kind_of(Predicate::BelongsTo) }
    specify{ subject.values.should == [:x] }
  end
  
  describe "when values contain duplicates" do
    let(:values){ [:x, :y, :x] }
    specify{ subject.values.should == [:x, :y] }
  end
  
end
