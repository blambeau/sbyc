require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::All#==" do
  
  let(:left) { SByC::Formulae::ALL }
  subject{ left == right }
  
  describe "All == All" do
    let(:right){ SByC::Formulae::ALL }
    it{ should == true }
  end
  
  describe "All == None" do
    let(:right){ SByC::Formulae::NONE }
    it{ should == false }
  end
  
  describe "All == BelongsTo" do
    let(:right){ SByC::Formulae::BelongsTo.new(:hello, [:x]) }
    it{ should == false }
  end
  
  describe "All == AllBut (empty)" do
    let(:right){ SByC::Formulae::AllBut.new(:hello, []) }
    it{ should == true }
  end
  
end