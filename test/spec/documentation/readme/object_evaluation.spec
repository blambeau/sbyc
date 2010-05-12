require File.expand_path('../../../spec_helper', __FILE__)

describe "README # object-evaluation section" do

  # expr = ::SByC::expr{ (x + y).to_s }        # (to_s (+ (? :x), (? :y)))
  # expr.eval(:x => 3, :y => 25)               # "28", executed as (x.+(y)).to_s()
    
  let(:expr){ ::SByC::expr{ (x + y).to_s } }
  
  describe('what is said about the ast') do
    subject{ expr.to_s }
    it { should == "(to_s (+ (? :x), (? :y)))" }
  end
  
  describe("what is said about eval") do
    subject{ expr.eval(:x => 3, :y => 25)  }
    it { should == "28" }
  end
  
end