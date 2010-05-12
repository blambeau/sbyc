require File.expand_path('../../../spec_helper', __FILE__)

describe "README # semantics section" do
  
  #     SByC::parse{ 12 }.inspect                         # (_ 12)
  #     SByC::parse{ :x }.inspect                         # (_ :x)
  #     SByC::parse{ x  }.inspect                         # (? (_ :x))
  # 
  # Leaf node (and therefore, the <code>_</code> operator) only appear when invoking inspect:
  # 
  #     SByC::parse{ x + 12 }.inspect                     # (+ (? (_ :x)), (_ 12))
  #     SByC::parse{ x + 12 }.to_s                        # (+ (? :x), 12)
  
  [
    [ lambda { 12 }, "(_ 12)" ],
    [ lambda { :x }, "(_ :x)" ],
    [ lambda { x  }, "(? (_ :x))" ]
  ].each do |expr, expected|
    specify { SByC::parse(expr).inspect.should == expected }
  end
  
  [
    [ lambda { x + 12 }, :inspect, "(+ (? (_ :x)), (_ 12))" ],
    [ lambda { x + 12 }, :to_s,    "(+ (? :x), 12)" ],
  ].each do |expr, meth, expected|
    specify { SByC::parse(expr).send(meth).should == expected }
  end
  
end
  
