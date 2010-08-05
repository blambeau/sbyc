require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::None::negation" do
  
  subject{ left.negation }
  
  describe "None.negation" do
    let(:left) { SByC::Formulae::NONE }
    it{ should == SByC::Formulae::ALL }
  end
  
end