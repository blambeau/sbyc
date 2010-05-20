require File.expand_path('../../../spec_helper', __FILE__)

describe "README # object-evaluation section" do

  let(:expr){ CodeTree::parse{ (x + y).to_s } }
  
  describe('what is said about the ast') do
    subject{ expr.to_s }
    it { should == "(to_s (+ x, y))" }
  end
  
  describe("what is said about eval") do
    subject{ expr.eval(:x => 3, :y => 25)  }
    it { should == "28" }
  end
  
end