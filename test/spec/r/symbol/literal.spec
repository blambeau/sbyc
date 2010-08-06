require File.expand_path('../../fixtures', __FILE__)
describe "R::Symbol.parse_literal" do
  
  SByC::Fixtures::R::SYMBOLS.each{|i|
    it "should not raise error on fixnum #{i}" do
      R::Symbol.parse_literal(R::Symbol.to_literal(i)).should == i
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad}" do
      lambda{ R::Symbol.parse_literal(bad) }.should raise_error(SByC::TypeError)
      lambda{ R::Symbol.parse_literal(bad.inspect) }.should raise_error(SByC::TypeError)
    end
  }
  
end
