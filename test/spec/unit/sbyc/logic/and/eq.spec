require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::And#==" do
  
  subject{ left == right }
  
  describe 'it should support abritrary order' do
    let(:left) { Logic::and(Logic::lt(:x, 18), Logic::gt(:y, 20)) }
    let(:right){ Logic::and(Logic::gt(:y, 20), Logic::gt(:x, 28)) }
    it{ pending("does not work yet") { should == true } }
  end
  
end
  
