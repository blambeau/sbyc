require File.expand_path('../../../fixtures', __FILE__)
describe "R::WrappedOperator.arg_matches?" do
  
  describe "on a monadic operator" do

    let(:op){ R::WrappedOperator.new([R::Boolean], R::Boolean, :&) }
    
    it "should match on true" do
      op.arg_matches?([true]).should == true
    end
    
    it "should match on false" do
      op.arg_matches?([true]).should == true
    end
    
    it "should not match on nil" do
      op.arg_matches?([nil]).should == false
    end
    
    it "should not match on too few args" do
      op.arg_matches?([]).should == false
    end
    
    it "should not match on too many args" do
      op.arg_matches?([true, true]).should == false
    end
    
  end

  describe "on a dyadic operator" do

    let(:op){ R::WrappedOperator.new([R::String, R::Integer], R::String, :*) }
    
    it "should match on valid args" do
      op.arg_matches?(["a", 3]).should == true
    end
    
    it "should match on reversed args" do
      op.arg_matches?([3, "a"]).should == false
    end
    
    it "should not match on too few args" do
      op.arg_matches?(["a"]).should == false
    end
    
    it "should not match on too many args" do
      op.arg_matches?(["a", 3, 4]).should == false
    end
    
  end

end