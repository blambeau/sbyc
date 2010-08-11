require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::AggregateSignature.arg_matches?" do
  
  let(:sign){ R::Operator::Signature::aggregate(R::Numeric) }
  
  it "should match on correct singleton with exact domain" do
    sign.arg_matches?([1]).should == true
    sign.arg_matches?([1.0]).should == true
  end
  
  it "should match on empty" do
    sign.arg_matches?([]).should == true
  end
  
  it "should match on correct args" do
    sign.arg_matches?([1, 5.0, 0]).should == true
  end
  
  it "should not match on incorrect args" do
    sign.arg_matches?([1, 5.0, ""]).should == false
  end
  
end