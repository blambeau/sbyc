require File.expand_path('../../fixtures', __FILE__)
describe "R::result_domain_by_args" do
  
  let(:args){ {:x => true, :y => false} }
  let(:invalid){ {:x => "hello", :y => false} }

  [ 
    lambda{ ~x },
    lambda{ x & y },
    lambda{ x | y },
    lambda{ ~(x | y) },
  ].each{|expr|

    it "should work on valid expression #{expr.to_s}" do
      res = R.result_domain_by_args(args, expr)
      res.should == R::Boolean
    end

    it "should work on valid expression #{expr.to_s} but invalid args" do
      lambda{ R.result_domain_by_args(invalid, expr) }.should raise_error(SByC::TypeCheckError)
    end

  }
  
  [ 
    lambda{ z },
    lambda{ (hello x) },
  ].each{|expr|

    it "should fail on on invalid expression #{expr.to_s}" do
      lambda{ R.result_domain_by_args(args, expr) }.should raise_error(SByC::TypeCheckError)
    end

  }
  
end