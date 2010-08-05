require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::All::negation" do
  
  subject{ left.negation }
  
  describe "All.negation" do
    let(:left) { SByC::Logic::ALL }
    it{ should == SByC::Logic::NONE }
  end
  
end