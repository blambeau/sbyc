require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::False#==" do
  
  let(:left) { SByC::Logic::FALSE }
  subject{ left == right }
  
  describe "False == False" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == true }
  end
  
  describe "False == True" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == false }
  end
  
end