require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::AggregateSignature.domain_matches?" do
  
  describe "on a complete signature" do

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
  
  describe "on an incomplete signature" do

    let(:sign){ R::Operator::Signature::aggregate(R::Operator::Signature::MATCHING_TERM) }

    it "should match if correct requester" do
      sign.domain_matches?([R::Numeric], R::Numeric).should == true
    end
  
    it "should match if correct requester but subdomain arg" do
      sign.domain_matches?([R::Integer], R::Numeric).should == true
    end
  
    it "should not match if incorrect requester" do
      sign.domain_matches?([R::Numeric], R::String).should == false
    end
  
    it "should not match if requester is too specialized" do
      sign.domain_matches?([R::Numeric], R::Float).should == false
    end
  
  end
  
end