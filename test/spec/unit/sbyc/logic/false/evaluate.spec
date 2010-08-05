require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::False#evaluate" do
  
  let(:operand){ Logic::FALSE }
  let(:context){ Hash.new }
  subject{ operand.evaluate(context) }
  
  it{ should == false }
  
end