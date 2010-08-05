require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::True#evaluate" do
  
  let(:operand){ Logic::TRUE }
  let(:context){ Hash.new }
  subject{ operand.evaluate(context) }
  
  it{ should == true }
  
end