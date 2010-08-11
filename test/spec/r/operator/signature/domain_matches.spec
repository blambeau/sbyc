require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::Signature.domain_matches?" do
  
  describe "on an empty signature" do

    let(:sign){ R::Operator::Signature.coerce([]) }
    
    it "should match on correct signature" do
      sign.domain_matches?([]).should == true
    end
    
    it "should not match on incorect signature" do
      sign.domain_matches?([R::String]).should == false
    end
    
  end
  
  describe "on a monadic signature" do

    let(:sign){ R::Operator::Signature.coerce([R::Boolean]) }
    
    it "should match on correct signature" do
      sign.domain_matches?([R::Boolean]).should == true
    end
    
    it "should not match on incorect signature" do
      sign.domain_matches?([R::String]).should == false
    end
    
    it "should not match on too few args" do
      sign.domain_matches?([]).should == false
    end
    
    it "should not match on too many args" do
      sign.domain_matches?([R::Boolean, R::Boolean]).should == false
    end
    
  end

  describe "on a dyadic signature" do
  
    let(:sign){ R::Operator::Signature.new([R::String, R::Integer]) }
    
    it "should match on valid args" do
      sign.domain_matches?([R::String, R::Integer]).should == true
    end
    
    it "should match on reversed args" do
      sign.domain_matches?([R::Integer, R::String]).should == false
    end
    
    it "should not match on too few args" do
      sign.domain_matches?([R::String]).should == false
    end
    
    it "should not match on too many args" do
      sign.domain_matches?([R::Integer, R::String, R::Boolean]).should == false
    end
    
  end
  
  describe 'on an incomplete signature' do

    let(:sign){ R::Operator::Signature.new([R::String, R::Operator::Signature::MATCHING_TERM]) }
    
    it 'should match on correct signature if good requester' do
      sign.domain_matches?([R::String, R::String], R::String).should be_true
    end
    
    it 'should not match on correct signature if not good requester' do
      sign.domain_matches?([R::String, R::String], R::Integer).should be_false
    end
    
  end

end