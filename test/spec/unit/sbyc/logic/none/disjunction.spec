require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::None::disjunction" do
  
  let(:left) { SByC::Logic::NONE }
  subject{ left.disjunction(right) }
  
  describe "None | None" do
    let(:right){ SByC::Logic::NONE }
    it{ should == SByC::Logic::NONE }
  end
  
  describe "None | All" do
    let(:right){ SByC::Logic::ALL }
    it{ should == SByC::Logic::ALL }
  end
  
  describe "None | BelongsTo" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, [:x, :y]) }
    it{ should == right }
  end
  
end