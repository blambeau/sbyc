require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::RegularSignature.domain_matches?" do
  
  describe "on an empty signature" do

    let(:sign){ R::Operator::Signature::regular{ } }
    
    it "should match on correct signature" do
      sign.domain_matches?([]).should == true
    end
    
    it "should not match on incorect signature" do
      sign.domain_matches?([R::String]).should == false
    end
    
  end
  
  describe "on a monadic signature" do
  
    let(:sign){ R::Operator::Signature::regular{ R::Boolean } }
    
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
  
    let(:sign){ R::Operator::Signature::regular{ (seq R::String, R::Integer) } }
    
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
  
  describe "on a star signature" do

    let(:sign){ R::Operator::Signature::regular{ (star R::Numeric) } }
  
    it "should match on empty signature" do
      sign.domain_matches?([]).should == true
    end
  
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
  
  describe "on a plus signature" do

    let(:sign){ R::Operator::Signature::regular{ (plus R::Numeric) } }
  
    it "should not match on empty signature" do
      sign.domain_matches?([]).should == false
    end
  
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
  
  # describe 'on an incomplete signature' do
  # 
  #   let(:sign){ R::Operator::Signature.new([R::String, R::Operator::Signature::MATCHING_TERM]) }
  #   
  #   it 'should match on correct signature if good requester' do
  #     sign.domain_matches?([R::String, R::String], R::String).should be_true
  #   end
  #   
  #   it 'should not match on correct signature if not good requester' do
  #     sign.domain_matches?([R::String, R::String], R::Integer).should be_false
  #   end
  #   
  # end

end