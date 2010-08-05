require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::None::negation" do
  
  subject{ left.negation }
  
  describe "None.negation" do
    let(:left) { SByC::Logic::NONE }
    it{ should == SByC::Logic::ALL }
  end
  
end