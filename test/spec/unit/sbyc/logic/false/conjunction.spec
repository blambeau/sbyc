require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::None::conjunction" do
  
  let(:left) { SByC::Logic::FALSE }
  subject{ left.conjunction(right) }
  
  describe "None & None" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == SByC::Logic::FALSE }
  end
  
  describe "None & All" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == SByC::Logic::FALSE }
  end
  
  describe "None & BelongsTo" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, [:x, :y]) }
    it{ should == SByC::Logic::FALSE }
  end
  
end