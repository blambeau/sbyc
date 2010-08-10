require File.expand_path('../../fixtures', __FILE__)
describe "R::Alpha's literal methods" do
  
  SByC::Fixtures::R::INTEGERS.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Alpha.parse_literal(R::Alpha.to_literal(i)).should == i
    end
  }
  
  SByC::Fixtures::R::STRINGS.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Alpha.parse_literal(R::Alpha.to_literal(i)).should == i
    end
  }
  
  [nil, '', "10lqsh"].each{|bad|
    it "should reject #{bad.inspect}" do
      lambda{ R::Numeric.parse_literal(bad) }.should raise_error(SByC::TypeError)
      lambda{ R::Numeric.parse_literal(bad.inspect) }.should raise_error(SByC::TypeError)
    end
  }
  
end
