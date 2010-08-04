require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::None::negation" do
  
  subject{ left.negation }
  
  describe "None.negation" do
    let(:left) { SByC::Predicate::NONE }
    it{ should == SByC::Predicate::ALL }
  end
  
end