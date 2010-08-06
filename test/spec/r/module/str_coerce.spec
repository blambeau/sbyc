require File.expand_path('../../fixtures', __FILE__)
describe "R::Module.str_coerce" do
  
  SByC::Fixtures::R::MODULES.each{|i|
    it "should not raise error on fixnum #{i}" do
      R::Module.str_coerce(i.inspect).should == i
    end
  }
  
end
