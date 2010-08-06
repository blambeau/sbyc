require File.expand_path('../../fixtures', __FILE__)
describe "R::Boolean.parse_literal" do
  
  SByC::Fixtures::R::BOOLEANS.each{|i|
    it "should accept #{i}" do
      R::Boolean.parse_literal(R::Boolean::to_literal(i)).should == i
    end
  }
  
  [nil, 'truef', 'fals' ''].each{|bad|
    it "should raise an error when called on bad literal #{bad}" do
      lambda{ R::Boolean.parse_literal(bad) }.should raise_error(SByC::TypeError)
    end
  }
  
end
