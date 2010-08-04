require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::None::conjunction" do
  
  let(:left) { SByC::Predicate::NONE }
  subject{ left.conjunction(right) }
  
  describe "None & None" do
    let(:right){ SByC::Predicate::NONE }
    it{ should == SByC::Predicate::NONE }
  end
  
  describe "None & All" do
    let(:right){ SByC::Predicate::ALL }
    it{ should == SByC::Predicate::NONE }
  end
  
  describe "None & BelongsTo" do
    let(:right){ SByC::Predicate::BelongsTo.new(:hello, [:x, :y]) }
    it{ should == SByC::Predicate::NONE }
  end
  
end