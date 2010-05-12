require File.expand_path('../../../../spec_helper', __FILE__)

describe "::SByC::Expr#eval" do

  let(:expr) { ::SByC::expr{x > z} }
  
  describe("when evaluated with a hash scope") {
    subject    { expr.eval(:x => 3, :z => 4)  }
    it { should == false }
    it("should support a call alias") {
      expr.call(:x => 3, :z => 4).should be_false
    }
  }

end