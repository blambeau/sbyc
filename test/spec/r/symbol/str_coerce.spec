require File.expand_path('../../fixtures', __FILE__)
describe "R::Symbol.str_coerce" do
  
  SByC::Fixtures::R::SYMBOLS.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Symbol.str_coerce(i.inspect).should == i
    end
  }
  
end
