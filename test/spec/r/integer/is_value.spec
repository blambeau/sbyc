require File.expand_path('../../fixtures', __FILE__)
describe "R::Integer.is_value?" do
  
  SByC::Fixtures::R::INTEGERS.each{|i|
    it "should accept #{i.inspect}" do
      R::Integer.is_value?(i).should == true
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad.inspect}" do
      R::Integer.is_value?(bad).should == false
    end
  }
  
end
