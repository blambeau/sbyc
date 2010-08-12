require File.expand_path('../../fixtures', __FILE__)
describe "R::Integer.coerce" do
  
  SByC::Fixtures::R::INTEGERS.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Integer.coerce(i.inspect).should == i
    end
  }
  
end
