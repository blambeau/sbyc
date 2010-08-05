require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::All::conjunction" do
  
  let(:left) { SByC::Formulae::ALL }
  subject{ left.conjunction(right) }
  
  describe "All & None" do
    let(:right){ SByC::Formulae::NONE }
    it{ should == SByC::Formulae::NONE }
  end
  
  describe "All & All" do
    let(:right){ SByC::Formulae::ALL }
    it{ should == SByC::Formulae::ALL }
  end
  
  describe "All & BelongsTo" do
    let(:right){ SByC::Formulae::BelongsTo.new(:hello, [:x, :y]) }
    it{ should == right }
  end
  
end