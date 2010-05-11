require File.expand_path('../../../spec_helper', __FILE__)

describe "README # assumptions section" do
  
  specify {
    SByC::parse{ x + 12 + 17     }.inspect.should == "(+ (+ (__scope_get__ :x), 12), 17)"
    SByC::parse{ x + (12 + 17)   }.inspect.should == "(+ (__scope_get__ :x), 29)"
    SByC::parse{ (x + 12) + 17   }.inspect.should == "(+ (+ (__scope_get__ :x), 12), 17)"

    SByC::parse{ if x then 0 else 1 end }.inspect.should == SByC::parse{ 0 }.inspect

    SByC::parse{ x and z }.inspect.should == "(__scope_get__ :z)"
    SByC::parse{ x && z  }.inspect.should == "(__scope_get__ :z)"
    SByC::parse{ x or z  }.inspect.should == "(__scope_get__ :x)"
    SByC::parse{ x || z  }.inspect.should == "(__scope_get__ :x)"
    SByC::parse{ not(x)  }.inspect.should == "false"
    SByC::parse{ !x      }.inspect.should == "false"
  }

end