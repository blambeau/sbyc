require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::All::disjunction" do
  
  let(:left) { SByC::Logic::TRUE }
  subject{ left.bool_or(right) }
  
  describe "True | False" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == SByC::Logic::TRUE }
  end
  
  describe "True | True" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == SByC::Logic::TRUE }
  end
  
end