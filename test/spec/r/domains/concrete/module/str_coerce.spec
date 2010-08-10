require File.expand_path('../../fixtures', __FILE__)
describe "R::Module.str_coerce" do
  
  SByC::Fixtures::R::MODULES.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Module.str_coerce(i.name).should == i
    end
  }
  
end
