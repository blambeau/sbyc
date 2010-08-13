require File.expand_path('../../../../spec_helper', __FILE__)
describe "Assumptions about module hierarchy" do
  
  module SByCFixturesModuleHierarchyFoo
    
    def hello
      "hello"
    end
    
  end
  
  module SByCFixturesModuleHierarchyBar
    
    def hello
      super
    end
    
  end
  
  class SByCFixturesModuleHierarchyClass
    extend SByCFixturesModuleHierarchyFoo
    extend SByCFixturesModuleHierarchyBar
    
  end

  it "should allow making super call" do
    SByCFixturesModuleHierarchyClass.hello.should == "hello"
  end
  
end