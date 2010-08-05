require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::AllBut::new" do
  
  subject{ Logic::AllBut.new(:hello, values) }
  
  describe "when values are empty" do
    let(:values){ [] }
    it{ should == Logic::ALL }
  end
  
  describe "when values are not empty" do
    let(:values){ [:x] }
    it{ should be_kind_of(Logic::AllBut) }
    specify{ subject.values.should == [:x] }
  end
  
  describe "when values contain duplicates" do
    let(:values){ [:x, :y, :x] }
    specify{ subject.values.should == [:x, :y] }
  end
  
end
