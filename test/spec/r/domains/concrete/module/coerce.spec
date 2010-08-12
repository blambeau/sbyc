require File.expand_path('../../fixtures', __FILE__)
describe "R::Module.coerce" do
  
  SByC::Fixtures::R::MODULES.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Module.coerce(i.name).should == i
    end
  }
  
end
