require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::AllBut::evaluate" do
  
  let(:factory){ Logic::Finite }
  let(:left) { factory::allbut(:var, [12, 13]) }
  subject{ left.evaluate(context) }
  
  describe "when value included" do
    let(:context){ {:var => 12} }
    it{ should == false }
  end
  
  describe "when value not included" do
    let(:context){ {:var => 15} }
    it{ should == true }
  end
  
end