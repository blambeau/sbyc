require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::All::negation" do
  
  subject{ left.bool_not }
  
  describe "~ True" do
    let(:left) { SByC::Logic::TRUE }
    it{ should == SByC::Logic::FALSE }
  end
  
end