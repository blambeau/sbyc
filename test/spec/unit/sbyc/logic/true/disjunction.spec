require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::All::disjunction" do
  
  let(:left) { SByC::Logic::TRUE }
  subject{ left.disjunction(right) }
  
  describe "All | None" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == SByC::Logic::TRUE }
  end
  
  describe "All | All" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == SByC::Logic::TRUE }
  end
  
  describe "All | BelongsTo" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, [:x, :y]) }
    it{ should == SByC::Logic::TRUE }
  end
  
end