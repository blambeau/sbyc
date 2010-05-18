require File.expand_path('../../../spec_helper', __FILE__)

describe "README # synopsis section" do
  
  let(:expr){ SByC::expr{ x > y } }
  
  specify {
    expr.to_s.should == "(> x, y)"
  }
  
  specify {
    expr.ast.to_s.should == "(> x, y)"
  }
  
  specify {
    expr.eval(:x => 5, :y => 2).should == true
  }
  
  describe "what is said about marshalling" do
    let(:mashaled)    { Marshal::dump(expr) }
    let(:unmarshaled) { Marshal::load(mashaled) }
    subject { unmarshaled.ast.to_s }
    it { should == expr.ast.to_s }
  end
  
end
  
