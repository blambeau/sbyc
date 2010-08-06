require File.expand_path('../../fixtures', __FILE__)
describe "R::Date.parse_literal" do
  
  SByC::Fixtures::R::DATES.each{|i|
    it "should not raise error on #{i}" do
      R::Date.str_coerce(i.to_s).should == i
    end
  }
    
end
