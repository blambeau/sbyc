require File.expand_path('../../../../spec_helper', __FILE__)

describe "::SByC::Expr" do

  let(:expr) { ::SByC::expr{x > z} }
  subject    { expr.ast            }
  
  specify {
    subject.inspect.should == "(> (? (_ :x)), (? (_ :z)))"
  }

end