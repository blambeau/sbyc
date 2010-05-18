require File.expand_path('../../../spec_helper', __FILE__)

describe "README # semantics section" do
  
  [
    [ lambda { 12 }, "(_ 12)" ],
    [ lambda { :x }, "(_ :x)" ],
    [ lambda { x  }, "(? (_ :x))" ]
  ].each do |expr, expected|
    specify { SByC::parse(expr).inspect.should == expected }
  end
  
  [
    [ lambda { x + 12 }, :inspect, "(+ (? (_ :x)), (_ 12))" ],
    [ lambda { x + 12 }, :to_s,    "(+ x, 12)" ],
  ].each do |expr, meth, expected|
    specify { SByC::parse(expr).send(meth).should == expected }
  end
  
end
  
