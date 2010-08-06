require File.expand_path('../fixtures', __FILE__)
describe "R, in evaluation mode" do
  it "should behave correctly" do
    context = {:x => 12} 
    R::evaluate(context){ x }.should == context[:x]
    R::evaluate(context){ x + 2 }.should == context[:x]+2
    R::evaluate(context){ (plus x, 2) }.should == context[:x]+2
    R::evaluate(context){ x - 2 }.should == context[:x]-2
    R::evaluate(context){ (minus x, 2) }.should == context[:x]-2
    R::evaluate(context){ (times x, 2) }.should == context[:x]*2
  end
end