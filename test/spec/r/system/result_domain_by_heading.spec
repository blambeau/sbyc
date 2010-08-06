require File.expand_path('../../fixtures', __FILE__)
describe "R::result_domain_by_heading" do
  
  let(:heading){ {:x => R::Boolean, :y => R::Boolean} }

  [ 
    lambda{ x },
    lambda{ ~x },
    lambda{ x & y },
    lambda{ x | y },
    lambda{ ~(x | y) },
  ].each{|expr|

    it "should work on valid expression #{expr.to_s}" do
      res = R.result_domain_by_heading(heading, expr)
      res.should == R::Boolean
    end

  }
  
  [ 
    lambda{ z },
    lambda{ (hello x) },
  ].each{|expr|

    it "should fail on on invalid expression #{expr.to_s}" do
      lambda{ R.result_domain_by_heading(heading, expr) }.should raise_error(SByC::TypeCheckError)
    end

  }
  
end