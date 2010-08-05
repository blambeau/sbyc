require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::None#==" do
  
  let(:left) { SByC::Formulae::NONE }
  subject{ left == right }
  
  describe "None == None" do
    let(:right){ SByC::Formulae::NONE }
    it{ should == true }
  end
  
  describe "None == All" do
    let(:right){ SByC::Formulae::ALL }
    it{ should == false }
  end
  
  describe "None == AllBut" do
    let(:right){ SByC::Formulae::AllBut.new(:hello, [:x]) }
    it{ should == false }
  end
  
  describe "None == BelongsTo (empty)" do
    let(:right){ SByC::Formulae::BelongsTo.new(:hello, []) }
    it{ should == true }
  end
  
end