require File.expand_path('../../fixtures', __FILE__)
describe "R::Date.coerce" do
  
  SByC::Fixtures::R::DATES.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Date.coerce(i.to_s).should == i
    end
  }
    
end
