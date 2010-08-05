require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::True#==" do
  
  let(:left) { SByC::Logic::TRUE }
  subject{ left == right }
  
  describe "True == True" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == true }
  end
  
  describe "True == False" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == false }
  end
  
end