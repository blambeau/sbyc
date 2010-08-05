require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::None::negation" do
  
  subject{ left.bool_not }
  
  describe "~ False" do
    let(:left) { SByC::Logic::FALSE }
    it{ should == SByC::Logic::TRUE }
  end
  
end