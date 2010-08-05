require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::All::negation" do
  
  subject{ left.negation }
  
  describe "All.negation" do
    let(:left) { SByC::Formulae::ALL }
    it{ should == SByC::Formulae::NONE }
  end
  
end