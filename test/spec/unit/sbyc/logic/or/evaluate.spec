require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::Or::evaluate" do
  
  let(:factory){ Logic::Ordered }
  
  # x < 20
  let(:x_20){ factory::lt(:x, 20) }
  
  # y > 20
  let(:y_20){ factory::gt(:y, 20) }
  
  # (x < 20) & (y > 20)
  let(:left){ Logic::Or.new([x_20,y_20]) }
  
  subject{ left.evaluate(context) }
  
  describe "when included" do
    let(:context){ { :x => 10, :y => 10} }
    it{ should == true }
  end
  
  describe "when not included (edge)" do
    let(:context){ { :x => 20, :y => 20} }
    it{ should == false }
  end
  
  describe "when not included" do
    let(:context){ { :x => 25, :y => 15} }
    it{ should == false }
  end
  
end