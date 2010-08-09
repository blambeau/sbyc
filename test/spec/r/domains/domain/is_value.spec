require File.expand_path('../../../fixtures', __FILE__)
describe "R::Domain.is_value?" do
  
  SByC::Fixtures::R::DOMAINS.each{|i|
    it "should accept #{i.inspect}" do
      R::Domain.is_value?(i).should == true
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad.inspect}" do
      R::Domain.is_value?(bad).should == false
    end
  }
  
end
