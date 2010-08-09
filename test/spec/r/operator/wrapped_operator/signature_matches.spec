require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator.signature_matches?" do
  
  describe "on a monadic operator" do

    let(:op){ R::WrappedOperator.new([R::Boolean], R::Boolean, :&) }
    
    it "should match on correct signature" do
      op.signature_matches?([R::Boolean]).should == true
    end
    
    it "should not match on incorect signature" do
      op.signature_matches?([R::String]).should == false
    end
    
    it "should not match on too few args" do
      op.signature_matches?([]).should == false
    end
    
    it "should not match on too many args" do
      op.signature_matches?([R::Boolean, R::Boolean]).should == false
    end
    
  end

  describe "on a dyadic operator" do
  
    let(:op){ R::WrappedOperator.new([R::String, R::Integer], R::String, :*) }
    
    it "should match on valid args" do
      op.signature_matches?([R::String, R::Integer]).should == true
    end
    
    it "should match on reversed args" do
      op.signature_matches?([R::Integer, R::String]).should == false
    end
    
    it "should not match on too few args" do
      op.signature_matches?([R::String]).should == false
    end
    
    it "should not match on too many args" do
      op.signature_matches?([R::Integer, R::String, R::Boolean]).should == false
    end
    
  end

end