require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::All::conjunction" do
  
  let(:left) { SByC::Logic::ALL }
  subject{ left.conjunction(right) }
  
  describe "All & None" do
    let(:right){ SByC::Logic::NONE }
    it{ should == SByC::Logic::NONE }
  end
  
  describe "All & All" do
    let(:right){ SByC::Logic::ALL }
    it{ should == SByC::Logic::ALL }
  end
  
  describe "All & BelongsTo" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, [:x, :y]) }
    it{ should == right }
  end
  
end