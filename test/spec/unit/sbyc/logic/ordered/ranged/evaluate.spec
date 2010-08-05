require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Ordered::Ranged::evaluate" do
  
  let(:factory){ Logic::Ordered }
  let(:left) { factory::gt(:var, 0) }
  subject{ left.evaluate(context) }
  
  describe "when value included" do
    let(:context){ {:var => 12} }
    it{ should == true }
  end
  
  describe "when value not included (edge)" do
    let(:context){ {:var => 0} }
    it{ should == false }
  end
  
  describe "when value not included (edge)" do
    let(:context){ {:var => -2} }
    it{ should == false }
  end
  
end