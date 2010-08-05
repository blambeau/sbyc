require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::False::conjunction" do
  
  let(:left) { SByC::Logic::FALSE }
  subject{ left.bool_and(right) }
  
  describe "False & False" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == SByC::Logic::FALSE }
  end
  
  describe "False & True" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == SByC::Logic::FALSE }
  end
  
end