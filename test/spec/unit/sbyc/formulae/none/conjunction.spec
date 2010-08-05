require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::None::conjunction" do
  
  let(:left) { SByC::Formulae::NONE }
  subject{ left.conjunction(right) }
  
  describe "None & None" do
    let(:right){ SByC::Formulae::NONE }
    it{ should == SByC::Formulae::NONE }
  end
  
  describe "None & All" do
    let(:right){ SByC::Formulae::ALL }
    it{ should == SByC::Formulae::NONE }
  end
  
  describe "None & BelongsTo" do
    let(:right){ SByC::Formulae::BelongsTo.new(:hello, [:x, :y]) }
    it{ should == SByC::Formulae::NONE }
  end
  
end