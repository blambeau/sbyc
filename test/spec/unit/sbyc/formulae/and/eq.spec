require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::And#==" do
  
  subject{ left == right }
  
  describe 'it should support abritrary order' do
    let(:left) { Formulae::and(Formulae::lt(:x, 18), Formulae::gt(:y, 20)) }
    let(:right){ Formulae::and(Formulae::gt(:y, 20), Formulae::gt(:x, 28)) }
    it{ pending("does not work yet") { should == true } }
  end
  
end
  
