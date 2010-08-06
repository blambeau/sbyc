require File.expand_path('../../fixtures', __FILE__)
describe "R::Float.parse_literal" do
  
  SByC::Fixtures::R::FLOATS.each{|i|
    it "should not raise error on fixnum #{i}" do
      R::Float.parse_literal(R::Float.to_literal(i)).should == i
    end
  }
  
  [nil, '', "10lqsh"].each{|bad|
    it "should reject #{bad}" do
      lambda{ R::Float.parse_literal(bad) }.should raise_error(SByC::TypeError)
      lambda{ R::Float.parse_literal(bad.inspect) }.should raise_error(SByC::TypeError)
    end
  }
  
end
