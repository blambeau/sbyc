require File.expand_path('../../fixtures', __FILE__)
describe "R::Integer.str_coerce" do
  
  SByC::Fixtures::R::INTEGERS.each{|i|
    it "should not raise error on fixnum #{i}" do
      R::Integer.str_coerce(i.inspect).should == i
    end
  }
  
end
