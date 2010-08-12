require File.expand_path('../../fixtures', __FILE__)
describe "R::Time.coerce" do
  
  SByC::Fixtures::R::TIMES.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Time.coerce(i.inspect).should == i
    end
  }
    
end
