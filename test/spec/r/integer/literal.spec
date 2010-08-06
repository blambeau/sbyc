require File.expand_path('../../../spec_helper', __FILE__)
describe "R::Integer.parse_literal" do
  
  [ -(2**(0.size * 8 - 2)), -1, 0, 1, 10, (2**(0.size * 8 - 2) - 1)].each{|i|
    it "should not raise error on fixnum #{i}" do
      R::Integer.parse_literal(R::Integer.to_literal(i)).should == i
    end
  }
  
  [ -(2**(0.size * 8 - 2)) - 1, (2**(0.size * 8 - 2)) ].each{|i|
    it "should not raise error on bignum #{i}" do
      R::Integer.parse_literal(R::Integer.to_literal(i)).should == i
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad}" do
      lambda{ R::Integer.parse_literal(bad) }.should raise_error(SByC::TypeError)
      lambda{ R::Integer.parse_literal(bad.inspect) }.should raise_error(SByC::TypeError)
    end
  }
  
end
