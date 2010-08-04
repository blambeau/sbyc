require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::And#==" do
  
  subject{ left == right }
  
  describe 'it should support abritrary order' do
    let(:left) { Predicate::and(Predicate::lt(:x, 18), Predicate::gt(:y, 20)) }
    let(:right){ Predicate::and(Predicate::gt(:y, 20), Predicate::gt(:x, 28)) }
    it{ pending("does not work yet") { should == true } }
  end
  
end
  
