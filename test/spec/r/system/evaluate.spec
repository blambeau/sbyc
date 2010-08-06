require File.expand_path('../../fixtures', __FILE__)
describe "R::evaluate" do
  
  let(:args){ {:x => true, :y => false} }

  it "should work when called on valid expressions" do
    R::evaluate(args){ ~x }.should == false
  end
  
end