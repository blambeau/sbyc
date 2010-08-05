require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::And::evaluate" do
  
  let(:factory){ Logic::Ordered }
  
  # x < 20
  let(:x_20){ factory::lt(:x, 20) }
  
  # y > 20
  let(:y_20){ factory::gt(:y, 20) }
  
  # (x < 20) & (y > 20)
  let(:left){ Logic::And.new([x_20,y_20]) }
  
  subject{ left.evaluate(context) }
  
  describe "when included" do
    let(:context){ { :x => 10, :y => 30} }
    it{ should == true }
  end
  
  describe "when not included (edge)" do
    let(:context){ { :x => 20, :y => 30} }
    it{ should == false }
  end
  
  describe "when not included" do
    let(:context){ { :x => 19, :y => 15} }
    it{ should == false }
  end
  
end