require File.expand_path('../../fixtures', __FILE__)
describe "R::Module.parse_literal" do
  
  SByC::Fixtures::R::MODULES.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Module.parse_literal(R::Module.to_literal(i)).should == i
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad.inspect}" do
      lambda{ R::Module.parse_literal(bad) }.should raise_error(SByC::TypeError)
      lambda{ R::Module.parse_literal(bad.inspect) }.should raise_error(SByC::TypeError)
    end
  }
  
end
