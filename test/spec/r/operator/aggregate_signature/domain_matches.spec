require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::AggregateSignature.domain_matches?" do
  
  let(:sign){ R::Operator::Signature::aggregate(R::Numeric) }
  
  it "should match on correct singleton signature with exact domain" do
    sign.domain_matches?([R::Numeric]).should == true
  end
  
  it "should match on correct singleton signature with sub domain" do
    sign.domain_matches?([R::Integer]).should == true
  end

  it "should match on correct signature" do
    sign.domain_matches?([R::Numeric, R::Integer, R::Float]).should == true
  end

  it "should not match on correct signature" do
    sign.domain_matches?([R::Numeric, R::Boolean, R::Float]).should == false
  end
  
end