require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::BelongsTo::evaluate" do
  
  let(:factory){ Logic::Finite }
  let(:left) { factory::belongs_to(:var, [12, 13]) }
  subject{ left.evaluate(context) }
  
  describe "when value included" do
    let(:context){ {:var => 12} }
    it{ should == true }
  end
  
  describe "when value not included" do
    let(:context){ {:var => 15} }
    it{ should == false }
  end
  
end