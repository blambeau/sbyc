require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::All::negation" do
  
  subject{ left.negation }
  
  describe "All.negation" do
    let(:left) { SByC::Predicate::ALL }
    it{ should == SByC::Predicate::NONE }
  end
  
end