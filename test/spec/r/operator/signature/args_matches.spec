require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::Signature.arg_matches?" do
  
  describe "on an empty signature" do

    let(:op){ R::Operator::Signature::regular{ } }
    
    it "should match on correct signature" do
      op.arg_matches?([]).should == true
    end
    
    it "should not match on incorect signature" do
      op.arg_matches?([12]).should == false
    end
    
  end
  
  describe "on a monadic signature" do

    let(:op){ R::Operator::Signature::regular{ R::Boolean } }
    
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
  
    let(:op){ R::Operator::Signature.regular{ (seq R::String, R::Integer) } }
    
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
  
  describe "on a signature with non trivial type inheritance" do
  
    let(:op){ R::Operator::Signature::regular{ (seq R::Numeric, R::Integer) } }
    
    it "should match on valid args" do
      op.arg_matches?([1, 1]).should == true
      op.arg_matches?([1.0, 1]).should == true
    end
    
    it "should not match on invalid args" do
      op.arg_matches?([5, 5.0]).should == false
    end
    
  end
  
  describe "on a star signature" do
    
    let(:sign){ R::Operator::Signature::regular{ (star R::Numeric) } }
  
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
  
  describe "on a plus signature" do
    
    let(:sign){ R::Operator::Signature::regular{ (plus R::Numeric) } }
  
    it "should match on correct singleton with exact domain" do
      sign.arg_matches?([1]).should == true
      sign.arg_matches?([1.0]).should == true
    end
  
    it "should not match on empty" do
      sign.arg_matches?([]).should == false
    end
  
    it "should match on correct args" do
      sign.arg_matches?([1, 5.0, 0]).should == true
    end
  
    it "should not match on incorrect args" do
      sign.arg_matches?([1, 5.0, ""]).should == false
    end
    
  end
  
  describe "on the signature of scalar-domain" do
    let(:sign){ R::Operator::Signature::regular{ (seq R::Symbol, (plus R::Symbol, R::Domain)) }}
    
    it "should match on valid args" do
      sign.arg_matches?([ :X, :name, R::String, :age, R::Integer ]).should == true
    end
  end

end