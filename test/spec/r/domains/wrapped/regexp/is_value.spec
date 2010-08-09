require File.expand_path('../../fixtures', __FILE__)
describe "R::Regexp.is_value?" do
  
  SByC::Fixtures::R::REGEXPS.each{|i|
    it "should accept #{i.inspect}" do
      R::Regexp.is_value?(i).should == true
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad.inspect}" do
      R::Regexp.is_value?(bad).should == false
    end
  }
  
end
