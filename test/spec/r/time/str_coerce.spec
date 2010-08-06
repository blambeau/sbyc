require File.expand_path('../../fixtures', __FILE__)
describe "R::Time.parse_literal" do
  
  SByC::Fixtures::R::TIMES.each{|i|
    it "should not raise error on #{i}" do
      R::Time.str_coerce(i.inspect).should == i
    end
  }
    
end
