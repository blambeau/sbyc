require File.expand_path('../../../spec_helper', __FILE__)

describe "README # assumptions section" do
  
  [
    [ proc{ x + 12 + 17   }, "(+ (+ (__scope_get__ :x), 12), 17)" ],
    [ proc{ x + (12 + 17) }, "(+ (__scope_get__ :x), 29)"         ],
    [ proc{ (x + 12) + 17 }, "(+ (+ (__scope_get__ :x), 12), 17)" ],
    [ proc{ if x then 0 else 1 end }, "0"],
    [ proc{ x and z }, "(__scope_get__ :z)"],
    [ proc{ x && z }, "(__scope_get__ :z)"],
    [ proc{ x or z }, "(__scope_get__ :x)"],
    [ proc{ x || z }, "(__scope_get__ :x)"],
    [ proc{ not(x) }, "false"],
    [ proc{ !(x) }, "false"]
  ].each{|test|
    specify { SByC::parse(test[0]).to_s.should == test[1] }  
  }
  

end