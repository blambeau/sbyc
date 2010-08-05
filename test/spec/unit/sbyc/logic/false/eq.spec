require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::None#==" do
  
  let(:left) { SByC::Logic::FALSE }
  subject{ left == right }
  
  describe "None == None" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == true }
  end
  
  describe "None == All" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == false }
  end
  
  describe "None == AllBut" do
    let(:right){ SByC::Logic::AllBut.new(:hello, [:x]) }
    it{ should == false }
  end
  
  describe "None == BelongsTo (empty)" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, []) }
    it{ should == true }
  end
  
end