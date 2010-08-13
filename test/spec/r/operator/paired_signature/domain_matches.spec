require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::PairedSignature.domain_matches?" do
  
  let(:sign){ R::Operator::Signature::paired(R::Symbol, R::Numeric) }
  
  it "should match on empty" do
    sign.domain_matches?([]).should == true
  end
  
  it "should match on correct singleto" do
    sign.domain_matches?([R::Symbol, R::Integer]).should == true
    sign.domain_matches?([R::Symbol, R::Float]).should == true
  end
  
  it "should match on correct varargs" do
    sign.domain_matches?([R::Symbol, R::Integer, R::Symbol, R::Float]).should == true
  end
  
  it "should not match on even number of args" do
    sign.domain_matches?([R::Symbol]).should == false
  end
  
  it "should not match on invalid args" do
    sign.domain_matches?([R::String, R::Integer]).should == false
  end
  
end