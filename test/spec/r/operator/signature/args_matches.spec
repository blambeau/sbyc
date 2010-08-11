require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::Signature.arg_matches?" do
  
  describe "on an empty signature" do

    let(:op){ R::Operator::Signature.coerce([]) }
    
    it "should match on correct signature" do
      op.arg_matches?([]).should == true
    end
    
    it "should not match on incorect signature" do
      op.arg_matches?([12]).should == false
    end
    
  end
  
  describe "on a monadic signature" do

    let(:op){ R::Operator::Signature.coerce([R::Boolean]) }
    
    it "should match on correct signature" do
      op.arg_matches?([true]).should == true
    end
    
    it "should not match on incorect signature" do
      op.arg_matches?([""]).should == false
    end
    
    it "should not match on too few args" do
      op.arg_matches?([]).should == false
    end
    
    it "should not match on too many args" do
      op.arg_matches?([true, false]).should == false
    end
    
  end

  describe "on a dyadic signature" do
  
    let(:op){ R::Operator::Signature.new([R::String, R::Integer]) }
    
    it "should match on valid args" do
      op.arg_matches?(["", 5]).should == true
    end
    
    it "should not match on reversed args" do
      op.arg_matches?([5, ""]).should == false
    end
    
    it "should not match on too few args" do
      op.arg_matches?([""]).should == false
    end
    
    it "should not match on too many args" do
      op.arg_matches?(["", 5, true]).should == false
    end
    
  end

  describe "on a complex signature" do
  
    let(:op){ R::Operator::Signature.new([R::Numeric, R::Integer]) }
    
    it "should match on valid args" do
      op.arg_matches?([1, 1]).should == true
      op.arg_matches?([1.0, 1]).should == true
    end
    
    it "should not match on invalid args" do
      op.arg_matches?([5, 5.0]).should == false
    end
    
  end

  describe 'on an incomplete signature' do

    let(:sign){ R::Operator::Signature.new([R::String, R::Operator::Signature::MATCHING_TERM]) }
    
    it 'should match on correct signature if good requester' do
      sign.arg_matches?(["hello", "world"], R::String).should be_true
    end
    
    it 'should not match on correct signature if not good requester' do
      sign.arg_matches?(["hello", "world"], R::Integer).should be_false
    end
    
  end

end