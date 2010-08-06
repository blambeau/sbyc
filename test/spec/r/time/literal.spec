require File.expand_path('../../fixtures', __FILE__)
describe "R::Time.parse_literal" do
  
  SByC::Fixtures::R::TIMES.each{|i|
    it "should not raise error on fixnum #{i}" do
      R::Time.parse_literal(R::Time.to_literal(i)).should == i
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad}" do
      lambda{ R::Time.parse_literal(bad) }.should raise_error(SByC::TypeError)
      lambda{ R::Time.parse_literal(bad.inspect) }.should raise_error(SByC::TypeError)
    end
  }
  
end
