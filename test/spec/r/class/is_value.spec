require File.expand_path('../../fixtures', __FILE__)
describe "R::Class.is_value?" do
  
  SByC::Fixtures::R::CLASSES.each{|i|
    it "should accept #{i.inspect}" do
      R::Class.is_value?(i).should == true
    end
  }
  
  SByC::Fixtures::R::STRICT_MODULES.each{|i|
    it "should reject #{i.inspect}" do
      R::Class.is_value?(i).should == false
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad.inspect}" do
      R::Class.is_value?(bad).should == false
    end
  }
  
end
