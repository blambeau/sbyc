require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::PairedSignature.arg_matches?" do
  
  let(:sign){ R::Operator::Signature::paired(R::Symbol, R::Numeric) }
  
  it "should match on empty" do
    sign.arg_matches?([]).should == true
  end
  
  it "should match on correct singleto" do
    sign.arg_matches?([:hello, 12]).should == true
    sign.arg_matches?([:hello, 1.0]).should == true
  end
  
  it "should match on correct varargs" do
    sign.arg_matches?([:hello, 12, :world, 14.0]).should == true
  end
  
  it "should not match on even number of args" do
    sign.arg_matches?([:hello, 12, :world]).should == false
  end
  
  it "should not match on invalid args" do
    sign.arg_matches?(["hello", 12]).should == false
  end
  
end