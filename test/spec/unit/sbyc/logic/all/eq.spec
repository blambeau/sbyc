require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::All#==" do
  
  let(:left) { SByC::Logic::ALL }
  subject{ left == right }
  
  describe "All == All" do
    let(:right){ SByC::Logic::ALL }
    it{ should == true }
  end
  
  describe "All == None" do
    let(:right){ SByC::Logic::NONE }
    it{ should == false }
  end
  
  describe "All == BelongsTo" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, [:x]) }
    it{ should == false }
  end
  
  describe "All == AllBut (empty)" do
    let(:right){ SByC::Logic::AllBut.new(:hello, []) }
    it{ should == true }
  end
  
end