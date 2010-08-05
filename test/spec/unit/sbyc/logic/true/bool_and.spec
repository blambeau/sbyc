require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::True::conjunction" do
  
  let(:left) { SByC::Logic::TRUE }
  subject{ left.bool_and(right) }
  
  describe "True & False" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == SByC::Logic::FALSE }
  end
  
  describe "True & True" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == SByC::Logic::TRUE }
  end
  
end