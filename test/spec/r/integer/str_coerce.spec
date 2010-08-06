require File.expand_path('../../../spec_helper', __FILE__)
describe "R::Integer.str_coerce" do
  
  [ -(2**(0.size * 8 - 2)), -1, 0, 1, 10, (2**(0.size * 8 - 2) - 1)].each{|i|
    it "should not raise error on fixnum #{i}" do
      R::Integer.str_coerce(i.inspect).should == i
    end
  }
  
  [ -(2**(0.size * 8 - 2)) - 1, (2**(0.size * 8 - 2)) ].each{|i|
    it "should not raise error on bignum #{i}" do
      R::Integer.str_coerce(i.inspect).should == i
    end
  }
  
end
