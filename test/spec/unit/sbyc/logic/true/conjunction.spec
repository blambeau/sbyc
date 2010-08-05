require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::True::conjunction" do
  
  let(:left) { SByC::Logic::TRUE }
  subject{ left.conjunction(right) }
  
  describe "True & False" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == SByC::Logic::FALSE }
  end
  
  describe "True & True" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == SByC::Logic::TRUE }
  end
  
  describe "True & BelongsTo" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, [:x, :y]) }
    it{ should == right }
  end
  
end