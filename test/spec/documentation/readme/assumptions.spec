require File.expand_path('../../../spec_helper', __FILE__)

describe "README # assumptions section" do
  
  [
    [ proc{ x + 12 + 17   }, "(+ (+ x, 12), 17)" ],
    [ proc{ x + (12 + 17) }, "(+ x, 29)"         ],
    [ proc{ (x + 12) + 17 }, "(+ (+ x, 12), 17)" ],
    [ proc{ if x then 0 else 1 end }, "0"],
    [ proc{ x and z }, "z"],
    [ proc{ x && z }, "z"],
    [ proc{ x or z }, "x"],
    [ proc{ x || z }, "x"],
  ].each{|test|
    specify { SByC::parse(test[0]).to_s.should == test[1] }  
  }
  
  if RUBY_VERSION < "1.9.0" 
    [ [ proc{ !(x) }, "false"],
      [ proc{ not(x) }, "false"]
    ].each{|test|
      specify { SByC::parse(test[0]).to_s.should == test[1] }  
    }
  else
    [ [ proc{ !(x) }, "(! x)"],
      [ proc{ not(x) }, "(! x)"]
    ].each{|test|
      specify { SByC::parse(test[0]).to_s.should == test[1] }  
    }
  end
  

end