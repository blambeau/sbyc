require File.expand_path('../../fixtures', __FILE__)
describe "R::Symbol.is_value?" do
  
  SByC::Fixtures::R::SYMBOLS.each{|i|
    it "should accept #{i.inspect}" do
      R::Symbol.is_value?(i).should == true
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad.inspect}" do
      R::Symbol.is_value?(bad).should == false
    end
  }
  
end
