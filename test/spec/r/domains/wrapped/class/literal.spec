require File.expand_path('../../fixtures', __FILE__)
describe "R::Class.parse_literal" do
  
  SByC::Fixtures::R::CLASSES.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Class.parse_literal(R::Class.to_literal(i)).should == i
    end
  }
  
  SByC::Fixtures::R::STRICT_MODULES.each{|i|
    it "should raise an error on #{i.inspect}" do
      lambda{ R::Class.parse_literal(R::Module.to_literal(i)) }.should raise_error(SByC::TypeError)
    end
  }
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad.inspect}" do
      lambda{ R::Class.parse_literal(bad) }.should raise_error(SByC::TypeError)
      lambda{ R::Class.parse_literal(bad.inspect) }.should raise_error(SByC::TypeError)
    end
  }
  
end
