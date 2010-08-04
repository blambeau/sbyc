require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::None#==" do
  
  let(:left) { SByC::Predicate::NONE }
  subject{ left == right }
  
  describe "None == None" do
    let(:right){ SByC::Predicate::NONE }
    it{ should == true }
  end
  
  describe "None == All" do
    let(:right){ SByC::Predicate::ALL }
    it{ should == false }
  end
  
  describe "None == AllBut" do
    let(:right){ SByC::Predicate::AllBut.new(:hello, [:x]) }
    it{ should == false }
  end
  
  describe "None == BelongsTo (empty)" do
    let(:right){ SByC::Predicate::BelongsTo.new(:hello, []) }
    it{ should == true }
  end
  
end