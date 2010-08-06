require File.expand_path('../../../spec_helper', __FILE__)
describe "Assumptions about instance_eval" do

  it "should support passing no-args block" do
    p = lambda{ 12 }
    lambda{ 
      if RUBY_VERSION >= "1.9.2"
        Object.new.instance_exec(&p).should == 12
      else
        Object.new.instance_eval(&p).should == 12 
      end
    }.should_not raise_error
  end
  
end