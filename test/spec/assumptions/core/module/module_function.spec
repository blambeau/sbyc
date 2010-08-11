require File.expand_path('../../../../spec_helper', __FILE__)
describe "Assumptions about module_function" do
  
  module SByCFixturesModuleFunctionFoo
    
    def hello
      "hello"
    end
    module_function :hello
    
  end
  
  class SByCFixturesModuleFunctionBar
    include SByCFixturesModuleFunctionFoo
  end

  it "should be accessible with the module as receiver" do
    SByCFixturesModuleFunctionFoo.hello.should == "hello"
  end
  
  it "should not be accessible by module inclusion" do
    lambda{ SByCFixturesModuleFunctionBar.new.hello.should }.should raise_error
  end
  
end