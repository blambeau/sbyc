require File.expand_path('../../fixtures', __FILE__)
describe "R::Float.is_value?" do
  
  SByC::Fixtures::R::FLOATS.each{|i|
    it "should accept fixnum #{i}" do
      R::Float.is_value?(i).should == true
    end
  }
  
  [nil, '', "10lqsh", 0, -1].each{|bad|
    it "should reject #{bad}" do
      R::Float.is_value?(bad).should == false
    end
  }
  
end
