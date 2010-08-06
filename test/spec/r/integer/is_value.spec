require File.expand_path('../../../spec_helper', __FILE__)
describe "R::Integer.is_value?" do
  
  [ -(2**(0.size * 8 - 2)), -1, 0, 1, 10, (2**(0.size * 8 - 2) - 1)].each{|i|
    it "should accept fixnum #{i}" do
      R::Integer.is_value?(i).should == true
    end
  }
  
  [ -(2**(0.size * 8 - 2)) - 1, (2**(0.size * 8 - 2)) ].each{|i|
    it "should accept bignum #{i}" do
      R::Integer.is_value?(i).should == true
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad}" do
      R::Integer.is_value?(bad).should == false
    end
  }
  
end
