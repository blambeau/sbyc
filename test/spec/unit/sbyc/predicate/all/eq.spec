require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::All#==" do
  
  let(:left) { SByC::Predicate::ALL }
  subject{ left == right }
  
  describe "All == All" do
    let(:right){ SByC::Predicate::ALL }
    it{ should == true }
  end
  
  describe "All == None" do
    let(:right){ SByC::Predicate::NONE }
    it{ should == false }
  end
  
  describe "All == BelongsTo" do
    let(:right){ SByC::Predicate::BelongsTo.new(:hello, [:x]) }
    it{ should == false }
  end
  
  describe "All == AllBut (empty)" do
    let(:right){ SByC::Predicate::AllBut.new(:hello, []) }
    it{ should == true }
  end
  
end