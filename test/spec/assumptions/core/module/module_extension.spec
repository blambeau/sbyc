require File.expand_path('../../../../spec_helper', __FILE__)
describe "Assumptions about module extension" do
  
  module SByCFixturesModuleExtensionFoo
    
    def hello
      "hello"
    end
    
    extend(SByCFixturesModuleExtensionFoo)
  end
  
  class SByCFixturesModuleExtensionBar
    include SByCFixturesModuleExtensionFoo
  end

  it "should be accessible with the module as receiver" do
    SByCFixturesModuleExtensionFoo.hello.should == "hello"
  end
  
  it "should not be accessible by module inclusion" do
    SByCFixturesModuleExtensionBar.new.hello.should == "hello"
  end
  
end