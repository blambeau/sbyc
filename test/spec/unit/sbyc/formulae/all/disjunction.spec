require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::All::disjunction" do
  
  let(:left) { SByC::Formulae::ALL }
  subject{ left.disjunction(right) }
  
  describe "All | None" do
    let(:right){ SByC::Formulae::NONE }
    it{ should == SByC::Formulae::ALL }
  end
  
  describe "All | All" do
    let(:right){ SByC::Formulae::ALL }
    it{ should == SByC::Formulae::ALL }
  end
  
  describe "All | BelongsTo" do
    let(:right){ SByC::Formulae::BelongsTo.new(:hello, [:x, :y]) }
    it{ should == SByC::Formulae::ALL }
  end
  
end