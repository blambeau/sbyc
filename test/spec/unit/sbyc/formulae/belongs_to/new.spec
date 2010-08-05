require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::BelongsTo::new" do
  
  subject{ Formulae::BelongsTo.new(:hello, values) }
  
  describe "when values are empty" do
    let(:values){ [] }
    it{ should == Formulae::NONE }
  end
  
  describe "when values are not empty" do
    let(:values){ [:x] }
    it{ should be_kind_of(Formulae::BelongsTo) }
    specify{ subject.values.should == [:x] }
  end
  
  describe "when values contain duplicates" do
    let(:values){ [:x, :y, :x] }
    specify{ subject.values.should == [:x, :y] }
  end
  
end
