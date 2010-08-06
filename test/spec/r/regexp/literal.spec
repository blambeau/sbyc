require File.expand_path('../../fixtures', __FILE__)
describe "R::Regexp.parse_literal" do
  
  SByC::Fixtures::R::REGEXPS.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Regexp.parse_literal(R::Regexp.to_literal(i)).should == i
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad.inspect}" do
      lambda{ R::Regexp.parse_literal(bad) }.should raise_error(SByC::TypeError)
      lambda{ R::Regexp.parse_literal(bad.inspect) }.should raise_error(SByC::TypeError)
    end
  }
  
end
