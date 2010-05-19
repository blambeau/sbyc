require File.expand_path('../../../spec_helper', __FILE__)

describe "README # synopsis section" do
  
  let(:expr){ CodeTree::expr{ x > y } }
  
  specify {
    expr.to_s.should == "(> x, y)"
  }
  
  specify {
    expr.inspect.should == "(> (? (_ :x)), (? (_ :y)))"
  }
  
  specify {
    expr.eval(:x => 5, :y => 2).should == true
  }
  
  describe "what is said about marshalling" do
    let(:marshaled)    { Marshal::dump(expr)      }
    let(:unmarshaled)  { Marshal::load(marshaled) }
    subject { unmarshaled }
    it { should == expr }
  end
  
end
  
